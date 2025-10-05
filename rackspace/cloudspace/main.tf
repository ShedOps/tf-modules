resource "spot_cloudspace" "default" {
  cloudspace_name    = var.cloudspace_name
  # You can find the available region names in the `regions` data source.
  region             = var.spot_region
  hacontrol_plane    = var.hacontrol_plane
  wait_until_ready   = true
  kubernetes_version = var.kubernetes_version 
  cni                = var.kubernetes_cni
}
