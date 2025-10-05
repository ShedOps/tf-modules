variable "as_min_nodes" {
  description = "Minium number of compute nodes, in an autoscaling group"
  type        = number
  default     = 0.002
}

variable "as_max_nodes" {
  description = "Maximum number of compute nodes, in an autoscaling group"
  type        = number
  default     = 0.002
}

variable "bid_price" {
  description = "Maximum bid price per hour for spot compute nodes"
  type        = number
  default     = 0.002
}

variable "cloudspace_name" {
  description = "Name of the rackspace cloudspace environment"
  type        = string
  default     = "example-cloudspace"
}

variable "hacontrol_plane" {
  description = "Kubernetes control plane high availability"
  type        = bool
  default     = false
}

variable "kubernetes_cni" {
  description = "Kubernetes Container Network Interface (CNI - networking model)"
  type        = string
  default     = "calico"
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  type        = string
  default     = "1.31.1"
}

variable "rackspace_spot_token" {
  description = "Rackspace Spot authentication token"
  type        = string
  sensitive   = true
}

variable "spot_compute_preference" {
  description = "Compute preference for the Kubernetes spot nodes"
  type        = string
  default     = "Compute Virtual Server.Medium"
}

variable "spot_serverclass_cpu" {
  description = "Server class CPU preference for the Kubernetes spot nodes"
  type        = string
  default     = "2"
}

variable "spot_serverclass_memory" {
  description = "Server class MEMORY preference for the Kubernetes spot nodes"
  type        = string
  default     = "<=4GB"
}

variable "spot_region" {
  description = "Rackspace Spot region"
  type        = string
  default     = "LONDON"
}
