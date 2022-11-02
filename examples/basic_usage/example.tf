module "container" {
  source  = "so1omon563/ecs-container-definition/aws"
  version = "1.0.0" # Replace with appropriate version

  name  = "nginx"
  image = "nginx:1.18-alpine"

  essential = true
  memory    = 64

  port_mappings = [8080]

  environment = {
    NGINX_PORT = 8080
  }
}

output "container_definition" {
  value = module.container
}
