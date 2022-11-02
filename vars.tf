variable "name" {
  description = "The name of the container"
}

variable "image" {
  description = "The image used for the container"
}

variable "container" {
  description = "The map of container definition properties to override defaults"
  type        = map(string)
  default     = {}
}

variable "_container" {
  description = "Default container definition properties, if not overridden in the container map"
  type        = map(string)
  default = {
    cpu_shares       = 0
    essential        = false
    hostname         = null
    interactive      = false
    mem_soft_limit   = 0
    mem_hard_limit   = 0
    networking       = true
    privileged       = false
    read_only_rootfs = false
    start_timeout    = 0
    stop_timeout     = 0
    terminal         = false
    user             = null
    workdir          = null

    private_repo_credentials = null
  }
}

variable "health_check" {
  type = object({
    command      = list(string)
    interval     = number
    timeout      = number
    retries      = number
    start_period = number
  })

  description = "The container health check command and associated configuration for the container"
  default     = null
}

variable "port_mappings" {
  type        = list(string)
  description = "A list of port mappings in the form of 'port' or 'port/protocol' where port is the container port to expose. Protocol is an optional value and defaults to 'tcp'"
  default     = []
}

variable "entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = null
}

variable "command" {
  type        = list(string)
  description = "The command that is passed to the container"
  default     = null
}

variable "environment" {
  type        = map(string)
  description = "The key/value map of environment variables to pass to a container."
  default     = {}
}

variable "links" {
  type        = list(string)
  description = "Create a legacy Docker link between containers"
  default     = null
}

variable "dns_servers" {
  type        = list(string)
  description = "A list of DNS servers that are presented to the container"
  default     = null
}

variable "dns_search_domains" {
  type        = list(string)
  description = "A list of DNS search domains that are presented to the container"
  default     = null
}

variable "security_options" {
  type        = list(string)
  description = "A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "A key/value map of labels to add to the container"
  default     = null
}

variable "secrets" {
  type        = map(string)
  description = "A map of secret resources. Key is the name of the secret used by the container, value is the ARN of the secret in Secrets Manager or Parameter Store"
  default     = {}
}

variable "depends" {
  type        = map(string)
  description = "A map of dependencies for this container. Key is the name of the container we depend on, value is that state of that container to satisfy the dependency"
  default     = {}
}

variable "extra_hosts" {
  type        = map(string)
  description = "A map of host name keys and their corresponding IP address as the value to append to the /etc/hosts file on the container"
  default     = {}
}

variable "sysctls" {
  type        = map(string)
  description = "A map of kernel sysctls to set on the container. Keys are the sysctl name"
  default     = {}
}

variable "resource_requirements" {
  type        = map(string)
  description = "The type and amount of a resource to assign to a container. Key is the resource type"
  default     = {}
}

variable "volumes_from" {
  type        = map(bool)
  description = "Data volumes to mount from another container. Keys are the contain name, value is a boolean to set the read-only status of the volume"
  default     = {}
}

variable "ulimits" {
  type        = map(string)
  description = "A map of ulimits to set in the container. Key is the ulimit name, value is in the form 'soft_limit:hard_limit'"
  default     = {}
}

variable "mount_points" {
  type        = map(string)
  description = "A map of mount points to configure in the container. Key is the path on the container to mount the volume at, value is in the form 'volume_name:read_only'"
  default     = {}
}

variable "firelens_config" {
  type = object({
    type    = string
    options = map(string)
  })

  description = "The FireLens configuration for the container"
  default     = null
}

variable "log_config" {
  type = object({
    driver  = string
    options = map(string)
    secrets = map(string)
  })

  description = "The log configuration specification for the container"
  default     = null
}