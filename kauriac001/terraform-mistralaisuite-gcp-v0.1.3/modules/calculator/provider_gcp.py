import os
import re
from typing import List, Tuple

from google.api_core.exceptions import GoogleAPICallError
from google.auth import default as gauth_default
from google.cloud import compute_v1
from provider import CloudProvider


class GCPProvider(CloudProvider):
    def __init__(self, cloud_tenant_id: str, cloud_region: str) -> None:
        super().__init__(cloud_tenant_id=cloud_tenant_id, cloud_region=cloud_region)
        self.project_id = (
            self.cloud_tenant_id
            or os.getenv("GOOGLE_CLOUD_PROJECT")
            or os.getenv("GCLOUD_PROJECT")
        )
        if not self.project_id:
            _, proj = gauth_default(
                scopes=["https://www.googleapis.com/auth/cloud-platform"]
            )
            self.project_id = proj
        if not self.project_id:
            raise ValueError(
                "GCP project ID is required. Pass cloud_tenant_id, set GOOGLE_CLOUD_PROJECT, "
                "or configure ADC."
            )

        self.machine_types_client = compute_v1.MachineTypesClient()

    def get_machine_available_zones(self, node_type: str) -> List[str]:
        try:
            request = compute_v1.AggregatedListMachineTypesRequest(
                project=self.project_id,
                filter=f"name={node_type}",
            )
            zones: list[str] = []
            for zone_name, scoped in self.machine_types_client.aggregated_list(
                request=request
            ):
                if not zone_name.startswith("zones/"):
                    continue
                z = zone_name[len("zones/") :]
                if re.match(rf"^{re.escape(self.cloud_region)}-", z) and getattr(
                    scoped, "machine_types", None
                ):
                    zones.append(z)
            return zones
        except GoogleAPICallError:
            return []

    def get_machine_specs(self, node_type: str, zone: str) -> Tuple[int, int]:
        try:
            request = compute_v1.GetMachineTypeRequest(
                project=self.project_id,
                zone=zone,
                machine_type=node_type,
            )
            mt = self.machine_types_client.get(request=request)
            cpu = int(mt.guest_cpus or 0)
            gpu = (
                int(mt.accelerators[0].guest_accelerator_count)
                if mt.accelerators
                else 0
            )
            return cpu, gpu
        except GoogleAPICallError:
            return 0, 0
