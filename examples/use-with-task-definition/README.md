# Use to pass in to a task definition

Example of passing in a container definition to a task definition using the output of this module.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

# Using the `ecs-container-definition` module to create 2 container definitions
module "container" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "2.0.0" # Replace with appropriate version

  name  = "nginx"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8080]

  environment_variables = {
    NGINX_PORT = 8080
  }
}

module "container2" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "2.0.0" # Replace with appropriate version

  name  = "nginx2"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8888]

  environment_variables = {
    NGINX_PORT = 8888
  }
}

# Creating a task using 1 of the container definitions
module "task-single" {
  source  = "so1omon563/ecs-task-definition/aws"
  version = "1.0.0" # Replace with appropriate version

  name = "single-task"
  # Put a single container in a task
  container_definitions = "[  ${module.container.json} ]"
  tags = {
    example = "true"
  }
}

output "task_single_definition" {
  value = module.task-single.task_definition
}

# Creating a task using multiple container definitions
module "task-multiple" {
  source  = "so1omon563/ecs-task-definition/aws"
  version = "1.0.0" # Replace with appropriate version

  name = "multiple-task"
  # Put multiple containers in a task
  container_definitions = "[  ${module.container.json}, ${module.container2.json} ]"
  tags = {
    example = "true"
  }
}

output "task_multiple_definition" {
  value = module.task-multiple.task_definition
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | so1omon563/ecs-container-definition/aws | 2.0.0 |
| <a name="module_container2"></a> [container2](#module\_container2) | so1omon563/ecs-container-definition/aws | 2.0.0 |
| <a name="module_task-multiple"></a> [task-multiple](#module\_task-multiple) | so1omon563/ecs-task-definition/aws | 1.0.0 |
| <a name="module_task-single"></a> [task-single](#module\_task-single) | so1omon563/ecs-task-definition/aws | 1.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_multiple_definition"></a> [task\_multiple\_definition](#output\_task\_multiple\_definition) | n/a |
| <a name="output_task_single_definition"></a> [task\_single\_definition](#output\_task\_single\_definition) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
