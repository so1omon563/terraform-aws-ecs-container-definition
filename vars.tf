variable "name" {
  description = "The name of the container."
}

variable "image" {
  description = "The image used for the container. This string is passed directly to the Docker daemon. By default, images in the Docker Hub registry are available. Other repositories are specified with either `repository-url/image:tag` or `repository-url/image@digest`. This parameter maps to `Image` in the [Create a container](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/#/create-a-container) section of the Docker Remote API and the `IMAGE` parameter of [docker run](https://docs.docker.com/engine/reference/run/)."
}

variable "command" {
  type        = list(string)
  description = "The command that's passed to the container. This parameter maps to `Cmd` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/) and the `COMMAND` parameter to [docker run](https://docs.docker.com/engine/reference/run/#security-configuration). For more information, see https://docs.docker.com/engine/reference/builder/#cmd. If there are multiple arguments, each argument is a separated string in the array."
  default     = null
}

variable "container" {
  type        = map(string)
  description = "The map of container definition properties to override defaults"
  default     = {}
}

variable "cpu" {
  type        = number
  description = "The number of cpu units reserved for the container. This is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of cpu reserved for all containers within a task be lower than the task-level cpu value."
  default     = 0
}

variable "depends" {
  type        = map(string)
  description = "A map of dependencies for this container. Key is the name of the container we depend on, value is that state of that container to satisfy the dependency"
  default     = {}
}

variable "disable_networking" {
  type        = bool
  description = "When this parameter is true, networking is disabled within the container. This parameter maps to `NetworkDisabled` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = false
}

variable "dns_search_domains" {
  type        = list(string)
  description = "A list of DNS search domains that are presented to the container"
  default     = null
}

variable "dns_servers" {
  type        = list(string)
  description = "A list of DNS servers that are presented to the container"
  default     = null
}

variable "docker_labels" {
  type        = map(string)
  description = "A key/value map of labels to add to the container. This parameter maps to `Labels` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}

variable "docker_security_options" {
  type        = list(string)
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. This field isn't valid for containers in tasks using the Fargate launch type. This parameter maps to `SecurityOpt` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}

variable "entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = null
}

variable "environment_variables" {
  type        = map(string)
  description = "The key/value map of environment variables to pass to a container. This parameter maps to `Env` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/) and the `--env` option to [docker run](https://docs.docker.com/engine/reference/run/)."
  default     = {}
}

variable "environment_files" {
  type        = list(string)
  description = "A list of files containing the environment variables to pass to a container. This parameter maps to the `--env-file` option to [docker run](https://docs.docker.com/engine/reference/run/)."
  default     = null
}

variable "essential" {
  type        = bool
  description = "Determines whether the container is marked as essential. All tasks must have at least one essential container. If you have an application that is composed of multiple containers, you should mark the main container as essential and all other containers as non-essential."
  default     = true
}

variable "extra_hosts" {
  type        = map(string)
  description = "A map of host name keys and their corresponding IP address as the value to append to the /etc/hosts file on the container"
  default     = {}
}

variable "firelens_config" {
  type = object({
    type    = string
    options = map(string)
  })

  description = "The FireLens configuration for the container.  This is used to specify and configure a log router for container logs. For more information, see [Custom Log Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`."
  default     = null
}

variable "health_check" {
  type = object({
    command      = list(string)
    interval     = number
    timeout      = number
    retries      = number
    start_period = number
  })

  description = "The container health check command and associated configuration for the container. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`. This parameter maps to `Healthcheck` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}

variable "hostname" {
  type        = string
  description = "The hostname to use for the container. Not supported if using awsvpc mode networking. This parameter maps to `Hostname` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}

variable "interactive" {
  type        = bool
  description = "When this parameter is true, an interactive shell is provided to the container, even if no command is specified. This parameter maps to `OpenStdin` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = false
}

variable "links" {
  type        = list(string)
  description = "Create a legacy Docker link between containers. Allows containers to communicate with each other without the need for port mappings. This parameter is only supported if the network mode of a task definition is bridge."
  default     = null
}

variable "linux_parameters" {
  type = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
    devices = list(object({
      host_path      = string
      container_path = string
      permissions    = list(string)
    }))
    init_process_enabled = bool
    max_swap             = number
    shared_memory_size   = number
    swappiness           = number
    tmpfs = list(object({
      container_path = string
      size           = number
      mount_options  = list(string)
    }))
  })

  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html). This parameter maps to `LinuxParameters` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/). Note that if using this variable, values must be provided for all of the properties, even if that value is `null`."
  default     = null
}
variable "log_config" {
  type = object({
    driver  = string
    options = map(string)
    secrets = map(string)
  })

  description = "The log configuration specification for the container. Note that if using this variable, values must be provided for all of the properties, even if that value is `null`."
  default     = null
}

variable "memory" {
  type        = number
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container memory, the container is killed. This field is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of memory reserved for all containers within a task be lower than the task memory value."
  default     = 0
}

variable "memory_reservation" {
  type        = number
  description = "The soft limit (in MiB) of memory to reserve for the container. When system memory is under heavy contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when it needs to, up to either the hard limit specified with the memory parameter (if applicable), or all of the available memory on the container instance, whichever comes first."
  default     = 0
}

variable "mount_points" {
  type        = map(string)
  description = "A map of mount points to configure in the container. Key is the path on the container to mount the volume at, value is in the form 'volume_name:read_only'"
  default     = {}
}

variable "port_mappings" {
  type        = list(string)
  description = "A list of port mappings in the form of 'port' or 'port/protocol' where port is the container port to expose. Protocol is an optional value and defaults to 'tcp'"
  default     = []
}

variable "privileged" {
  type        = bool
  description = "When this parameter is true, the container is given elevated privileges on the host container instance (similar to the root user). This parameter maps to `Privileged` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = false
}

variable "pseudo_terminal" {
  type        = bool
  description = "When this parameter is true, a TTY is allocated. This parameter maps to `Tty` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = false
}

variable "read_only_rootfs" {
  type        = bool
  description = "When this parameter is true, the container is given read-only access to its root file system. This parameter maps to `ReadonlyRootfs` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = false
}

variable "repository_credentials" {
  type = object({
    credentials_parameter = string
  })

  description = "The private repository authentication credentials to use in the form of the Amazon Resource Name (ARN) of the secret containing the private repository credentials."
  default     = null
}

variable "resource_requirements" {
  type        = map(string)
  description = "The type and amount of a resource to assign to a container. Key is the resource type. The only supported resource type is currently `GPU`."
  default     = {}
}

variable "secrets" {
  type        = map(string)
  description = "A map of secret resources. Key is the name of the secret used by the container, value is the ARN of the secret in Secrets Manager or Parameter Store"
  default     = {}
}

variable "start_timeout" {
  type        = number
  description = "Time duration (in seconds) to wait before giving up on resolving dependencies for a container."
  default     = 0
}

variable "stop_timeout" {
  type        = number
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own."
  default     = 0
}

variable "system_controls" {
  type        = map(string)
  description = "A map of kernel sysctls to set on the container. Keys are the sysctl name. This parameter maps to `Sysctls` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = {}
}

variable "ulimits" {
  type        = map(string)
  description = "A map of ulimits to set in the container. Key is the ulimit name, value is in the form 'soft_limit:hard_limit'. This parameter maps to `Ulimits` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = {}
}

variable "user" {
  type        = string
  description = "The user name to use inside the container. This parameter maps to `User` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}

variable "volumes_from" {
  type        = map(bool)
  description = "Data volumes to mount from another container. Keys are the contain name, value is a boolean to set the read-only status of the volume"
  default     = {}
}

variable "working_directory" {
  type        = string
  description = "The working directory in which to run commands inside the container. This parameter maps to `WorkingDir` in the [Create a container](https://docs.docker.com/engine/api/v1.35/#tag/Container/operation/ContainerCreate) section of the [Docker Remote API](https://docs.docker.com/engine/api/v1.35/)."
  default     = null
}
