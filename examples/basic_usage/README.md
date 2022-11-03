# Basic usage

Basic quickstart for creating a container definition.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
module "container" {
  source = "../../"

  name  = "nginx"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8080]

  environment_variables = {
    NGINX_PORT = 8080
  }
}

output "container_definition" {
  value = module.container
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_definition"></a> [container\_definition](#output\_container\_definition) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
