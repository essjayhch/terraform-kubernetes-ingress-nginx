variable "default_resource_requests" {
  default = {
    cpu = "100m"
    memory = null
  }
  description = "Default Values (Do not set)"
}

variable "default_resource_limits"  {
  default = {
    cpu = null
    memory = null
  }
  description = "Default Values (Do not set)"
}

locals {
  actual_resource_requests = merge(var.default_resource_requests, var.resource_requests)
  actual_resource_limits = merge(var.default_resource_limits, var.resource_limits)
}
