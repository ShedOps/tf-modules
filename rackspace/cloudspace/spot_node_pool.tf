# Creates a spot node pool with an autoscaling pool
resource "spot_spotnodepool" "autoscaling-bid" {
  cloudspace_name = resource.spot_cloudspace.default.cloudspace_name
  # You can find the available server classes in the `serverclasses` data source.
  server_class = data.spot_serverclasses.all.name
  bid_price    = var.bid_price

  autoscaling = {
    min_nodes = var.as_min_nodes
    max_nodes = var.as_max_nodes
  }

  labels = {
    "managed-by"         = "Terraform"
   "environment"         = "Dev"
  }
}
