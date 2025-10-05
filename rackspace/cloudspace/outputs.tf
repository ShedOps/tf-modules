# terraform output -raw kubeconfig | \
#  aws secretsmanager put-secret-value --secret-id prod/kubeconfig --secret-string file:///dev/stdin
output "kubeconfig" {
  description = "Outputs the generated kubeconfig"
  value = data.spot_kubeconfig.example.raw
  sensitive = true
}

output "spot_region" {
  description = "Outputs the spot region in human readable format"
  value = data.spot_region.spot_region.description
}

output "spot_serverclass_names" {
  description = "Outputs the spot_serverclass_name in human readable format"
  value = data.spot_serverclasses.all.names
}
