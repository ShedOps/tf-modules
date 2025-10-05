terraform {
  required_providers {
    spot = {
      source  = "rackerlabs/spot"
      version = ">= 5.0"
    }
  }
  required_version = "~> 1.13.0"
}
