from abc import ABC, abstractmethod
from typing import List, Tuple


class CloudProvider(ABC):
    def __init__(self, cloud_tenant_id: str, cloud_region: str) -> None:
        self.cloud_tenant_id: str = cloud_tenant_id
        self.cloud_region: str = cloud_region

    @abstractmethod
    def get_machine_available_zones(self, node_type: str) -> List[str]:
        """Return available zones for a given node type in self.cloud_region."""
        raise NotImplementedError

    @abstractmethod
    def get_machine_specs(self, node_type: str, zone: str) -> Tuple[int, int]:
        """Return (cpu_count, gpu_count) for a given node type in a zone."""
        raise NotImplementedError
