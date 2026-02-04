#!/usr/bin/env python3
import json
import subprocess
import sys
import tempfile
from math import ceil
from typing import Any, Dict, List, Literal, Optional, Tuple, Union

import fire
import yaml
from provider import CloudProvider
from provider_aws import AWSProvider
from provider_azure import AzureProvider
from provider_gcp import GCPProvider


def ceil_divide(a: float, b: float) -> int:
    """Calculate ceiling division of a by b."""

    if a is None or b is None or b == 0:
        return 0
    try:
        return ceil(float(a) / float(b))
    except (ValueError, TypeError):
        return 0


def safe_float(value: Union[str, int, float, None]) -> float:
    """Safely convert a value to float, handling None and strings with units."""

    if value is None:
        return 0.0
    if isinstance(value, (int, float)):
        return float(value)
    if isinstance(value, str):
        try:
            if value.endswith("m"):  # Handle millicores (e.g., "500m")
                return float(value[:-1]) / 1000
            return float(value)
        except ValueError:
            return 0.0
    return 0.0


def get_cloud_provider(provider_name: str) -> CloudProvider:
    """Get the appropriate cloud provider class based on the provider name."""

    providers = {
        "aws": AWSProvider,
        "azure": AzureProvider,
        "gcp": GCPProvider,
    }
    if provider_name not in providers:
        raise ValueError(f"Unsupported cloud provider: {provider_name}")
    return providers[provider_name]


def run_helm_template(
    helm_chart: str,
    helm_chart_version: str,
    helm_chart_alues_file: str,
    output_file: str,
) -> None:
    """Run helm template command to generate the YAML manifest."""

    try:
        cmd = f"helm template mai-suite {helm_chart} --version {helm_chart_version} -f {helm_chart_alues_file} > {output_file}"
        subprocess.run(cmd, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running helm template: {e}", file=sys.stderr)
        sys.exit(1)


def process_containers(containers: List[Dict[str, Any]]) -> Tuple[float, float]:
    """Process a list of containers to calculate total CPU and GPU requests."""

    total_cpu = 0.0
    total_gpu = 0.0
    for container in containers:
        if not isinstance(container, dict):
            continue
        resources = container.get("resources", {})
        requests = resources.get("requests", {})
        cpu_request = requests.get("cpu")
        gpu_request = requests.get("nvidia.com/gpu")
        # Doesn't count CPU requests from GPU containers,
        # because we want to put apps on CPU nodes.
        if gpu_request is None:
            total_cpu += safe_float(cpu_request)
        total_gpu += safe_float(gpu_request)
    return total_cpu, total_gpu


def calculate_resource_requests(yaml_file: str) -> Tuple[float, float]:
    """Calculate total CPU and GPU requests from the YAML file."""

    total_cpu = 0.0
    total_gpu = 0.0
    try:
        with open(yaml_file, "r") as file:
            docs = list(yaml.safe_load_all(file))
    except (yaml.YAMLError, IOError) as e:
        print(f"Error reading YAML file: {e}", file=sys.stderr)
        return 0.0, 0.0
    for doc in docs:
        if not doc:
            continue
        kind = doc.get("kind")
        if kind not in ["Deployment", "StatefulSet"]:
            continue
        try:
            # Get replicas (default to 1 if not specified)
            replicas = doc.get("spec", {}).get("replicas", 1)
            replicas = int(replicas) if replicas is not None else 1
            # Get containers
            containers = (
                doc.get("spec", {})
                .get("template", {})
                .get("spec", {})
                .get("containers", [])
            )
            if not isinstance(containers, list):
                continue
            # Calculate resources per pod
            pod_cpu, pod_gpu = process_containers(containers)
            # Add to totals (replicas * pod_resources)
            total_cpu += replicas * pod_cpu
            total_gpu += replicas * pod_gpu
        except Exception:
            # Don't print debug messages, just continue silently
            continue
    return total_cpu, total_gpu


def main(
    helm_chart_uri: str,
    helm_chart_version: str,
    helm_chart_values_file: List[str],
    cpu_node_type: str,
    gpu_node_type: str,
    cloud_provider_name: Literal["aws", "azure", "gcp"],
    cloud_region: str,
    cloud_tenant_id: Optional[str] = None,
) -> Dict[str, str]:
    """Calculate node requirements for Kubernetes deployment."""
    try:
        # Get the correct cloud provider class
        provider = get_cloud_provider(cloud_provider_name)(
            cloud_tenant_id, cloud_region
        )

        # Get machine specs
        node_zones = provider.get_machine_available_zones(gpu_node_type)
        if not node_zones:
            raise RuntimeError(
                f"No zones found for instance type {gpu_node_type} in region {cloud_region}"
            )

        cpu_per_cpu_node, _ = provider.get_machine_specs(cpu_node_type, node_zones[0])
        _, gpu_per_gpu_node = provider.get_machine_specs(gpu_node_type, node_zones[0])

        # Create temporary manifest file using tempdir
        with tempfile.NamedTemporaryFile(delete=False) as file:
            manifest_file = file.name

        # Run helm template
        run_helm_template(
            helm_chart_uri, helm_chart_version, helm_chart_values_file, manifest_file
        )

        # Calculate resource requests
        total_cpu_requests, total_gpu_requests = calculate_resource_requests(
            manifest_file
        )

        # Add 20% buffer to CPU requests
        total_cpu_requests_with_buffer = total_cpu_requests * 1.2

        # Calculate GPU nodes count
        gpu_node_count = ceil_divide(total_gpu_requests, gpu_per_gpu_node)

        # Calculate CPU nodes count
        cpu_node_count = (
            ceil_divide(total_cpu_requests_with_buffer, cpu_per_cpu_node)
            if total_cpu_requests_with_buffer > 0
            else 0
        )

        # Output results in JSON format
        output = {
            "exit_code": "0",
            "cpu_node_count": str(cpu_node_count),
            "total_cpu_requests": str(total_cpu_requests),
            "cpu_per_gpu_node": str(cpu_per_cpu_node),
            "gpu_node_count": str(gpu_node_count),
            "total_gpu_requests": str(total_gpu_requests),
            "gpu_per_gpu_node": str(gpu_per_gpu_node),
            "node_zones": json.dumps(node_zones, ensure_ascii=False),
        }
        print(json.dumps(output, ensure_ascii=False))
    except Exception as e:
        output = {
            "exit_code": "1",
            "error": str(e),
            "cpu_node_count": None,
            "gpu_node_count": None,
            "node_zones": None,
        }
        print(json.dumps(output, ensure_ascii=False))


if __name__ == "__main__":
    fire.Fire(main)
