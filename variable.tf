# Variables

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "hub_name" {
  type    = string
  default = "hub-aro"
}

variable "spoke_name" {
  type    = string
  default = "spoke-aro"
}

variable "aro_spn_name" {
  type    = string
  default = "aro-lza-sp"
}

resource "random_password" "pw" {
  length      = 16
  special     = true
  min_lower   = 3
  min_special = 2
  min_upper   = 3

  keepers = {
    location = var.location
  }
}

resource "random_string" "user" {
  length  = 16
  special = false

  keepers = {
    location = var.location
  }
}

resource "random_string" "random" {
  length = 6
  special = false
  min_lower = 3
  min_upper = 1

  keepers = {
    location = var.location
  }
}
/*
variable "aro_rp_object_id" {
  type = string
}

variable "aro_base_name" {
  type = string
}

variable "aro_domain" {
  type = string
}
*/

variable "cluster_name" {
  type        = string
  default     = "aro-lz"
  description = "ARO cluster name"
}

variable "pull_secret_path" {
  type        = string
  default     = "~/Downloads/pull-secret.txt"
  description = <<EOF
  Pull Secret for the ARO cluster 
  Default "false"
  EOF
}
