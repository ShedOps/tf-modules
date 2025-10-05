# Find suitable spot_region from country preference
data "spot_region" "spot_region" {
    filters = [
    {
      name   = "country",
      values = [var.spot_region]
    }
  ]
}

# Find serverclasses that are from the category compute heavy
data "spot_serverclasses" "all" {
  filters = [
    {
      name   = "resources.cpu"
      values = [var.spot_serverclass_cpu]
    },
    {
      name   = "resources.memory"
      values = [var.spot_serverclass_memory]
    }
  ]
}
