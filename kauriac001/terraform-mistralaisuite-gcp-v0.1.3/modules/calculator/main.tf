data "external" "calculator" {
  program = [
    "bash",
    "${path.module}/run.sh",
    var.mistral_ai_suite_chart_uri,
    var.mistral_ai_suite_chart_version,
    "${path.cwd}/${var.mistral_ai_suite_chart_values_files.0}",
    var.cpu_node_type,
    var.gpu_node_type,
    var.cloud_provider_name,
    var.cloud_region,
    var.cloud_tenant_id,
  ]
}

locals {
  result = data.external.calculator.result
}

resource "null_resource" "calculator_check" {
  lifecycle {
    precondition {
      condition     = local.result.exit_code == "0"
      error_message = "Resource calculator script failed with exit code ${local.result.exit_code}: ${jsonencode(local.result)}"
    }
  }
}
