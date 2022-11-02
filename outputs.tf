output "json" {
  value = jsonencode(local.def)
}

output "value" {
  value = local.def
}