locals {
  container = merge(var._container, var.container)
  port_map  = [for m in var.port_mappings : { containerPort : tonumber(split("/", m)[0]), protocol : try(split("/", m)[1], "tcp"), hostPort : tonumber(try(split("/", m)[2], null)) }]
  env       = [for k, v in var.environment : { name : k, value : v }]
  secrets   = [for k, v in var.secrets : { name : k, valueFrom : v }]
  depends   = [for k, v in var.depends : { containerName : k, condition : v }]
  hosts     = [for k, v in var.extra_hosts : { hostname : k, ipAddress : v }]
  sysctls   = [for k, v in var.sysctls : { namespace : k, value : v }]
  resreqs   = [for k, v in var.resource_requirements : { type : k, value : v }]
  vols      = [for k, v in var.volumes_from : { sourceContainer : k, readOnly : v }]
  ulimits   = [for k, v in var.ulimits : { name : k, softLimit : split(":", v)[0], hardLimit : try(split(":", v)[1], split(":", v)[0]) }]
  mounts    = [for k, v in var.mount_points : { containerPath : k, sourceVolume : split(":", v)[0], readOnly : try(tobool(split(":", v)[1]), false) }]

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
    name              = var.name
    image             = var.image
    cpu               = local.container["cpu_shares"] > 0 ? tonumber(local.container["cpu_shares"]) : null
    disableNetworking = !local.container["networking"]
    essential         = tobool(local.container["essential"])
    interactive       = tobool(local.container["interactive"])
    privileged        = tobool(local.container["privileged"])
    pseudoTerminal    = tobool(local.container["terminal"])
    entryPoint        = var.entrypoint
    command           = var.command
    environment       = length(local.env) > 0 ? local.env : null
    hostname          = local.container["hostname"]
    user              = local.container["user"]
    workingDirectory  = local.container["workdir"]
    links             = var.links
    dockerLabels      = var.labels
    secrets           = length(local.secrets) > 0 ? local.secrets : null
    dependsOn         = length(local.depends) > 0 ? local.depends : null
    extraHosts        = length(local.hosts) > 0 ? local.hosts : null
    systemControls    = length(local.sysctls) > 0 ? local.sysctls : null
    volumesFrom       = length(local.vols) > 0 ? local.vols : null
    ulimits           = length(local.ulimits) > 0 ? local.ulimits : null
    mountPoints       = length(local.mounts) > 0 ? local.mounts : null
    logConfiguration  = local.log_config

    memory                 = local.container["mem_hard_limit"] > 0 ? tonumber(local.container["mem_hard_limit"]) : null
    memoryReservation      = local.container["mem_soft_limit"] > 0 ? tonumber(local.container["mem_soft_limit"]) : null
    healthCheck            = var.health_check
    portMappings           = length(local.port_map) > 0 ? local.port_map : null
    readonlyRootFilesystem = tobool(local.container["read_only_rootfs"])
    startTimeout           = local.container["start_timeout"] > 0 ? tonumber(local.container["start_timeout"]) : null
    stopTimeout            = local.container["stop_timeout"] > 0 ? tonumber(local.container["stop_timeout"]) : null
    dnsServers             = var.dns_servers
    dnsSearchDomains       = var.dns_search_domains
    dockerSecurityOptions  = var.security_options
    repositoryCredentials  = local.container["private_repo_credentials"] != null ? { credentialsParameter = local.container["private_repo_credentials"] } : null
    resourceRequirements   = length(local.resreqs) > 0 ? local.resreqs : null
    firelensConfiguration  = var.firelens_config
  }
}