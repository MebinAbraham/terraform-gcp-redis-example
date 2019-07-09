variable "region" {
  default = "europe-west2"
}

variable "gcp_billing_account" {
  description = "The billing account the project will use"
}

variable "gcp_folder_id" {
  description = "The numeric ID of the folder this project belongs to"
}

variable "env" {
  description = "Environment name - used as the project name in GCP"
}

variable "redis_ip_range" {
  description = "The redis subnetwork CIDR range"
  default     = "10.100.0.0/16"
}

variable "redis_storage_size" {
  description = "The amount of in-memory storage in GB for Redis"
  default     = 1
}