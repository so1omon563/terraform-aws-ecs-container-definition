locals {
  port_map = [for m in var.port_mappings : { containerPort : tonumber(split("/", m)[0]), protocol : try(split("/", m)[1], "tcp"), hostPort : tonumber(try(split("/", m)[2], null)) }]
  env      = [for k, v in var.environment : { name : k, value : v }]
  secrets  = [for k, v in var.secrets : { name : k, valueFrom : v }]
  depends  = [for k, v in var.depends : { containerName : k, condition : v }]
  hosts    = [for k, v in var.extra_hosts : { hostname : k, ipAddress : v }]
  sysctls  = [for k, v in var.system_controls : { namespace : k, value : v }]
  resreqs  = [for k, v in var.resource_requirements : { type : k, value : v }]
  vols     = [for k, v in var.volumes_from : { sourceContainer : k, readOnly : v }]
  ulimits  = [for k, v in var.ulimits : { name : k, softLimit : split(":", v)[0], hardLimit : try(split(":", v)[1], split(":", v)[0]) }]
  mounts   = [for k, v in var.mount_points : { containerPath : k, sourceVolume : split(":", v)[0], readOnly : try(tobool(split(":", v)[1]), false) }]

  log_config = var.log_config != null ? {
    logDriver : var.log_config.driver
    options : var.log_config.options
    secretOptions : [for k, v in var.log_config.secrets : { name : k, valueFrom : v }]
  } : null
}

// distinct local block for the container definition object, for clarity
// Attribute names (keys), and value structure, of the def object are directly taken from the AWS container definition
// JSON. See the containerDefinition element in the output of 'aws ecs register-task-definition --generate-cli-skeleton'
// Running 'aws ecs register-task-definition --generate-cli-skeleton | jq ".containerDefinitions[0]"' will make this
// more clear, and pretty.
locals {
  def = {
    name                  = var.name
    image                 = var.image
    repositoryCredentials = var.repository_credentials
    cpu                   = var.cpu > 0 ? var.cpu : null
    memory                = var.memory > 0 ? var.memory : null
    memoryReservation     = var.memory_reservation > 0 ? var.memory_reservation : null
    links                 = var.links
    portMappings          = length(local.port_map) > 0 ? local.port_map : null
    essential             = var.essential
    entryPoint            = var.entrypoint
    command               = var.command
    environment           = length(local.env) > 0 ? local.env : null
    environment_files     = var.environment_files
    mountPoints           = length(local.mounts) > 0 ? local.mounts : null
    volumesFrom           = length(local.vols) > 0 ? local.vols : null
    linuxParameters = var.linux_parameters != null ? {
      capabilities : {
        add : var.linux_parameters.capabilities.add
        drop : var.linux_parameters.capabilities.drop
      }
      devices : [for d in var.linux_parameters.devices : { hostPath : d.host_path, containerPath : d.container_path, permissions : d.permissions }]
      initProcessEnabled : var.linux_parameters.init_process_enabled
      sharedMemorySize : var.linux_parameters.shared_memory_size
      tmpfs : [for t in var.linux_parameters.tmpfs : { containerPath : t.container_path, size : t.size, mountOptions : t.mount_options }]
      maxSwap : var.linux_parameters.max_swap
      swappiness : var.linux_parameters.swappiness
    } : null
    secrets                = length(local.secrets) > 0 ? local.secrets : null
    dependsOn              = length(local.depends) > 0 ? local.depends : null
    startTimeout           = var.start_timeout > 0 ? var.start_timeout : null
    stopTimeout            = var.stop_timeout > 0 ? var.stop_timeout : null
    hostname               = var.hostname #
    user                   = var.user
    workingDirectory       = var.user
    disableNetworking      = var.disable_networking
    privileged             = var.privileged
    readonlyRootFilesystem = var.read_only_rootfs
    dnsServers             = var.dns_servers
    dnsSearchDomains       = var.dns_search_domains
    extraHosts             = length(local.hosts) > 0 ? local.hosts : null
    dockerSecurityOptions  = var.docker_security_options
    interactive            = var.interactive
    pseudoTerminal         = var.pseudo_terminal
    dockerLabels           = var.docker_labels
    ulimits                = length(local.ulimits) > 0 ? local.ulimits : null
    logConfiguration       = local.log_config
    healthCheck            = var.health_check
    systemControls         = length(local.sysctls) > 0 ? local.sysctls : null
    resourceRequirements   = length(local.resreqs) > 0 ? local.resreqs : null
    firelensConfiguration  = var.firelens_config
  }
}
