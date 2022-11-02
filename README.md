# Container Definition

A module to help define ECS container definitions using a more canonically Terraform method to define them.
ECS task definitions require the raw JSON of container definitions as inputs to the AWS provider's `aws_ecs_task_definition` resource,
which has historically limited the reuse-ability of common containers like logging, apm, or configuration rendering.
This module hopes to solve that by creating a Terraform-esque representation of a container definition which can then be
composed with other container definitions as part of a task definition.

## Input Variables

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| name | The name of the container | **Y** | |
| image | The image used for the container | **Y** | |
| container | The map of container definition properties to override defaults | N | empty map |
| command | The command that is passed to the container | N | null |
| entrypoint | The entry point that is passed to the container | N | null |
| environment | The key/value map of environment variables to pass to a container. | N | empty map |
| depends | A map of dependencies for this container. Key is the name of the container we depend on, value is that state of that container to satisfy the dependency | N | empty map |
| dns_servers | A list of DNS servers that are presented to the container | N | null |
| dns_search_domains | A list of DNS search domains that are presented to the container | N | null |
| extra_hosts | A map of host name keys and their corresponding IP address as the value to append to the /etc/hosts file on the container | N | empty map |
| health_check | The container health check command and associated configuration for the container | N | null |
| labels | A key/value map of labels to add to the container | N | null |
| links | A list of legacy Docker link between containers | N | null |
| mount_points | A map of mount points to configure in the container. Key is the path on the container to mount the volume at, value is in the form 'volume_name:read_only' | N | empty map |
| port_mappings | A list of port mappings in the form of 'containerPort' or 'containerPort/protocol' or 'containerPort/protocol/hostPort'. Protocol is an optional value and defaults to 'tcp'. The hostPort is also optionsl. | N | empty list |
| resource_requirements | The type and amount of a resource to assign to a container. Key is the resource type | N | empty map |
| secrets | A map of secret resources. Key is the name of the secret used by the container, value is the ARN of the secret in Secrets Manager or Parameter Store | N | empty map |
| security_options | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems | N | null |
| sysctls | A map of kernel sysctls to set on the container. Keys are the sysctl name | N | empty map |
| ulimits | A map of ulimits to set in the container. Key is the ulimit name, value is in the form 'soft_limit:hard_limit' | N | empty map |
| volumes_from | Data volumes to mount from another container. Keys are the contain name, value is a boolean to set the read-only status of the volume | N | empty map |
| firelens_config | The FireLens configuration for the container | N | null |
| log_config | The log configuration specification for the container | N | null |

### container Variable Defaults

These are the default container properties, use the `container` input variable map to override

| Name | Description | Value |
|------|-------------|-------|
| cpu_shares | The number of cpu shares reserved for the container | 0 |
| essential | If true, failure of this container stops all other containers that are part of the task | false |
| hostname | The hostname to use for your container | null |
| interactive | If true, allocate stdin or a tty to the container | false |
| mem_soft_limit | The soft memory limit (memoryReservation), in MiB. At least one of the mem_soft_limit or mem_hard_limit map keys must be defined for non-Fargate containers | 0 |
| mem_hard_limit | The hard memory limit, in MiB. At least one of the mem_soft_limit or mem_hard_limit map keys must be defined for non-Fargate containers | 0 |
| networking | If false, networking is disabled within the container | true |
| private_repo_credentials | The Amazon Resource Name (ARN) of the secret containing the private repository credentials | null |
| privileged | If true, the container is given elevated privileges on the host container instance | false |
| read_only_rootfs | If true, the container is given read-only access to its root file system | false |
| start_timeout | The start timeout settings (in seconds) for the container | 0 |
| stop_timeout | The stop timeout settings (in seconds) for the container | 0 |
| terminal | If true, a TTY is allocated | false |
| user | The user name to use inside the container | null |
| workdir | The working directory in which to run commands inside the container | null |

## Output Variables

| Name | Description |
|------|-------------|
| value | The Terraform object representing the container definition. |
| json | The JSON encoded representation of the object for the container definition. |

## Quick Start

```hcl-terraform
module "container" {
  source = "../../modules/container-definition"
  name   = "nginx"
  image  = "nginx:1.18-alpine"

  container = {
    essential      = true
    mem_hard_limit = 64
  }

  port_mappings = [8080]

  environment = {
    NGINX_PORT = 8080
  }
}
```

More configuration examples can be found in the [examples](../../examples) directory
