module "container" {
  source = "../../"
  name   = "nginx"
  image  = "nginx:1.18-alpine"

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
