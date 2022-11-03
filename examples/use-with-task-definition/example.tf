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
