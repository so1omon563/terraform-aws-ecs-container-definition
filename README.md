# Container Definition

A module to help define ECS container definitions using a more common Terraform method.

ECS task definitions require the raw JSON of container definitions as inputs to the AWS provider's `aws_ecs_task_definition` resource. This has historically limited the reusability of common containers like logging, etc.

This module hopes to solve that by creating a Terraform-esque representation of a container definition which can then be
composed with other container definitions as part of a task definition.

Note that only 1 container definition is supported per module instance. If you need to define multiple container definitions, you can use this module multiple times and string the `json` outputs together for your task definition.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | The command that's passed to the container. This parameter maps to `Cmd` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/) and the `COMMAND` parameter to [docker run](https://docs.docker.com/engine/reference/run/#security-configuration). For more information, see https://docs.docker.com/engine/reference/builder/#cmd. If there are multiple arguments, each argument is a separated string in the array. | `list(string)` | `null` | no |
| <a name="input_container"></a> [container](#input\_container) | The map of container definition properties to override defaults | `map(string)` | `{}` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units reserved for the container. This is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of cpu reserved for all containers within a task be lower than the task-level cpu value. | `number` | `0` | no |
| <a name="input_depends"></a> [depends](#input\_depends) | A map of dependencies for this container. Key is the name of the container we depend on, value is that state of that container to satisfy the dependency | `map(string)` | `{}` | no |
| <a name="input_disable_networking"></a> [disable\_networking](#input\_disable\_networking) | When this parameter is true, networking is disabled within the container. This parameter maps to `NetworkDisabled` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `bool` | `false` | no |
| <a name="input_dns_search_domains"></a> [dns\_search\_domains](#input\_dns\_search\_domains) | A list of DNS search domains that are presented to the container | `list(string)` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | A list of DNS servers that are presented to the container | `list(string)` | `null` | no |
| <a name="input_docker_labels"></a> [docker\_labels](#input\_docker\_labels) | A key/value map of labels to add to the container. This parameter maps to `Labels` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `map(string)` | `null` | no |
| <a name="input_docker_security_options"></a> [docker\_security\_options](#input\_docker\_security\_options) | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. This field isn't valid for containers in tasks using the Fargate launch type. This parameter maps to `SecurityOpt` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `list(string)` | `null` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | The entry point that is passed to the container | `list(string)` | `null` | no |
| <a name="input_environment_files"></a> [environment\_files](#input\_environment\_files) | A list of files containing the environment variables to pass to a container. This parameter maps to the `--env-file` option to [docker run](https://docs.docker.com/engine/reference/run/). | `list(string)` | `null` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The key/value map of environment variables to pass to a container. This parameter maps to `Env` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/) and the `--env` option to [docker run](https://docs.docker.com/engine/reference/run/). | `map(string)` | `{}` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | Determines whether the container is marked as essential. All tasks must have at least one essential container. If you have an application that is composed of multiple containers, you should mark the main container as essential and all other containers as non-essential. | `bool` | `true` | no |
| <a name="input_extra_hosts"></a> [extra\_hosts](#input\_extra\_hosts) | A map of host name keys and their corresponding IP address as the value to append to the /etc/hosts file on the container | `map(string)` | `{}` | no |
| <a name="input_firelens_config"></a> [firelens\_config](#input\_firelens\_config) | The FireLens configuration for the container.  This is used to specify and configure a log router for container logs. For more information, see [Custom Log Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`. | <pre>object({<br>    type    = string<br>    options = map(string)<br>  })</pre> | `null` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | The container health check command and associated configuration for the container. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`. This parameter maps to `Healthcheck` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | <pre>object({<br>    command      = list(string)<br>    interval     = number<br>    timeout      = number<br>    retries      = number<br>    start_period = number<br>  })</pre> | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname to use for the container. Not supported if using awsvpc mode networking. This parameter maps to `Hostname` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | The image used for the container. This string is passed directly to the Docker daemon. By default, images in the Docker Hub registry are available. Other repositories are specified with either `repository-url/image:tag` or `repository-url/image@digest`. This parameter maps to `Image` in the [Create a container](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/#/create-a-container) section of the Docker Remote API and the `IMAGE` parameter of [docker run](https://docs.docker.com/engine/reference/run/). | `any` | n/a | yes |
| <a name="input_interactive"></a> [interactive](#input\_interactive) | When this parameter is true, an interactive shell is provided to the container, even if no command is specified. This parameter maps to `OpenStdin` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `bool` | `false` | no |
| <a name="input_links"></a> [links](#input\_links) | Create a legacy Docker link between containers. Allows containers to communicate with each other without the need for port mappings. This parameter is only supported if the network mode of a task definition is bridge. | `list(string)` | `null` | no |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html). This parameter maps to `LinuxParameters` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). Note that if using this variable, values must be provided for all of the properties, even if that value is `null`. | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>    devices = list(object({<br>      host_path      = string<br>      container_path = string<br>      permissions    = list(string)<br>    }))<br>    init_process_enabled = bool<br>    max_swap             = number<br>    shared_memory_size   = number<br>    swappiness           = number<br>    tmpfs = list(object({<br>      container_path = string<br>      size           = number<br>      mount_options  = list(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_log_config"></a> [log\_config](#input\_log\_config) | The log configuration specification for the container. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`. | <pre>object({<br>    driver  = string<br>    options = map(string)<br>    secrets = map(string)<br>  })</pre> | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container memory, the container is killed. This field is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of memory reserved for all containers within a task be lower than the task memory value. | `number` | `0` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | The soft limit (in MiB) of memory to reserve for the container. When system memory is under heavy contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when it needs to, up to either the hard limit specified with the memory parameter (if applicable), or all of the available memory on the container instance, whichever comes first. | `number` | `0` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | A map of mount points to configure in the container. Key is the path on the container to mount the volume at, value is in the form 'volume\_name:read\_only' | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the container. | `any` | n/a | yes |
| <a name="input_port_mappings"></a> [port\_mappings](#input\_port\_mappings) | A list of port mappings in the form of 'port' or 'port/protocol' where port is the container port to expose. Protocol is an optional value and defaults to 'tcp' | `list(string)` | `[]` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user). This parameter maps to `Privileged` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `bool` | `false` | no |
| <a name="input_pseudo_terminal"></a> [pseudo\_terminal](#input\_pseudo\_terminal) | When this parameter is true, a TTY is allocated. This parameter maps to `Tty` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `bool` | `false` | no |
| <a name="input_read_only_rootfs"></a> [read\_only\_rootfs](#input\_read\_only\_rootfs) | When this parameter is true, the container is given read-only access to its root file system. This parameter maps to `ReadonlyRootfs` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `bool` | `false` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | The private repository authentication credentials to use in the form of the Amazon Resource Name (ARN) of the secret containing the private repository credentials. | <pre>object({<br>    credentials_parameter = string<br>  })</pre> | `null` | no |
| <a name="input_resource_requirements"></a> [resource\_requirements](#input\_resource\_requirements) | The type and amount of a resource to assign to a container. Key is the resource type. The only supported resource type is currently `GPU`. | `map(string)` | `{}` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of secret resources. Key is the name of the secret used by the container, value is the ARN of the secret in Secrets Manager or Parameter Store | `map(string)` | `{}` | no |
| <a name="input_start_timeout"></a> [start\_timeout](#input\_start\_timeout) | Time duration (in seconds) to wait before giving up on resolving dependencies for a container. | `number` | `0` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. | `number` | `0` | no |
| <a name="input_system_controls"></a> [system\_controls](#input\_system\_controls) | A map of kernel sysctls to set on the container. Keys are the sysctl name. This parameter maps to `Sysctls` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `map(string)` | `{}` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | A map of ulimits to set in the container. Key is the ulimit name, value is in the form 'soft\_limit:hard\_limit'. This parameter maps to `Ulimits` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `map(string)` | `{}` | no |
| <a name="input_user"></a> [user](#input\_user) | The user name to use inside the container. This parameter maps to `User` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `string` | `null` | no |
| <a name="input_volumes_from"></a> [volumes\_from](#input\_volumes\_from) | Data volumes to mount from another container. Keys are the contain name, value is a boolean to set the read-only status of the volume | `map(bool)` | `{}` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory in which to run commands inside the container. This parameter maps to `WorkingDir` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_json"></a> [json](#output\_json) | The JSON representation of the container definition. This can be used to pass to the `container_definitions` argument of the `aws_ecs_task_definition` resource. |
| <a name="output_terraform_value"></a> [terraform\_value](#output\_terraform\_value) | The Terraform object representing the container definition. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
