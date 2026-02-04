from typing import List, Optional, Tuple

import boto3
from botocore.exceptions import BotoCoreError, ClientError, ProfileNotFound
from provider import CloudProvider


class AWSProvider(CloudProvider):
    def __init__(self, cloud_tenant_id: str, cloud_region: str) -> None:
        super().__init__(cloud_tenant_id=cloud_tenant_id, cloud_region=cloud_region)

        self._session = self._create_session()

    def _create_session(self) -> boto3.Session:
        """Create boto3 session with profile fallback."""
        if not self.cloud_tenant_id:
            return boto3.Session(region_name=self.cloud_region)
        try:
            return boto3.Session(
                profile_name=self.cloud_tenant_id,
                region_name=self.cloud_region,
            )
        except ProfileNotFound:
            print(
                f"Profile '{self.cloud_tenant_id}' not found, using default credentials"
            )
            return boto3.Session(region_name=self.cloud_region)

    def _ec2_client(self, region: Optional[str] = None) -> None:
        return self._session.client("ec2", region_name=region or self.cloud_region)

    def get_machine_available_zones(self, node_type: str) -> List[str]:
        try:
            ec2 = self._ec2_client()
            resp = ec2.describe_instance_type_offerings(
                LocationType="availability-zone",
                Filters=[{"Name": "instance-type", "Values": [node_type]}],
            )
            return [o["Location"] for o in resp.get("InstanceTypeOfferings", [])]
        except (ClientError, BotoCoreError):
            return []

    def get_machine_specs(self, node_type: str, zone: str) -> Tuple[int, int]:
        try:
            region = zone[:-1] if zone else self.cloud_region
            ec2 = self._ec2_client(region=region)
            resp = ec2.describe_instance_types(InstanceTypes=[node_type])
            if not resp.get("InstanceTypes"):
                return 0, 0
            it = resp["InstanceTypes"][0]
            cpu = it.get("VCpuInfo", {}).get("DefaultVCpus", 0)
            gpu_info = it.get("GpuInfo", {})
            gpu = gpu_info.get("Gpus", [{}])[0].get("Count", 0) if gpu_info else 0
            return cpu, gpu
        except (ClientError, BotoCoreError):
            return 0, 0
