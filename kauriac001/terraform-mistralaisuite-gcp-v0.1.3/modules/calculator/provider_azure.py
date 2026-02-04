import os
from typing import List, Tuple

from azure.core.exceptions import AzureError
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from provider import CloudProvider


class AzureProvider(CloudProvider):
    def __init__(self, cloud_tenant_id: str, cloud_region: str) -> None:
        super().__init__(cloud_tenant_id=cloud_tenant_id, cloud_region=cloud_region)
        self.credential = DefaultAzureCredential()
        self.subscription_id = self.cloud_tenant_id or os.getenv(
            "AZURE_SUBSCRIPTION_ID"
        )
        if not self.subscription_id:
            raise ValueError(
                "Azure subscription ID is required. Pass cloud_tenant_id or set AZURE_SUBSCRIPTION_ID."
            )
        self.compute_client = ComputeManagementClient(
            credential=self.credential,
            subscription_id=self.subscription_id,
        )

    def get_machine_available_zones(self, node_type: str) -> List[str]:
        try:
            skus = self.compute_client.resource_skus.list(
                filter=f"location eq '{self.cloud_region}'"
            )
            zones: list[str] = []
            for sku in skus:
                if sku.resource_type == "virtualMachines" and sku.name == node_type:
                    for li in sku.location_info or []:
                        zones.extend(li.zones or [])
            seen = set()
            dedup = []
            for z in zones:
                if z not in seen:
                    seen.add(z)
                    dedup.append(f"{self.cloud_region}-{z}")
            return dedup
        except AzureError:
            return []

    def get_machine_specs(self, node_type: str, zone: str) -> Tuple[int, int]:
        try:
            if "-" in zone:
                region, zone_num = zone.rsplit("-", 1)
            else:
                region, zone_num = self.cloud_region, zone

            skus = self.compute_client.resource_skus.list(
                filter=f"location eq '{region}'"
            )
            for sku in skus:
                if sku.resource_type != "virtualMachines" or sku.name != node_type:
                    continue

                available = False
                for li in sku.location_info or []:
                    if li.zones and zone_num in li.zones:
                        available = True
                        break
                if not zone_num or available:
                    caps = {c.name: c.value for c in (sku.capabilities or [])}
                    cpu = int(caps.get("vCPUs", 0))
                    gpu = int(caps.get("GPUs", 0))
                    return cpu, gpu
            return 0, 0
        except AzureError:
            return 0, 0
