output "json" {
  description = "The JSON representation of the container definition. This can be used to pass to the `container_definitions` argument of the `aws_ecs_task_definition` resource. May require using `jsondecode` to facilitate this."
  value       = jsonencode(local.definition)
}

output "terraform_value" {
  description = "The Terraform object representing the container definition."
  value       = local.definition
}
