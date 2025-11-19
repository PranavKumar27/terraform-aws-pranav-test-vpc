variable "vpc_config" {
  description = "To get CIDR and VPC Name"
  type = object({
    cidr = string
    name = string 
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr))
    error_message = "Invalid CIDR value for Vpc config"
  }
}

variable "subnet_config"{
    description = "TO get Subnet Cidr and Availability Zones"
    type = map(object({
      cidr = string
      az = string 
      public = optional(bool,false)
    }))

    validation {
      condition = alltrue([for config in var.subnet_config: can(cidrnetmask(config.cidr))])
      error_message = "Invalid CIDR value for subnet config"
    }
}