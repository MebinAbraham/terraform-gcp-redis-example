provider "google" {
  region = "${var.region}"
}

resource "google_project" "project" {
  name            = "${var.env}"
  project_id      = "${var.env}"
  folder_id       = "${var.gcp_folder_id}"
  billing_account = "${var.gcp_billing_account}"

  lifecycle {
    ignore_changes = ["project_id", "name"]
  }
}

resource "google_project_service" "redis" {
  project = "${google_project.project.project_id}"
  service = "redis.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

resource "google_redis_instance" "memorystore" {
  name              = "memory-cache"
  tier              = "STANDARD_HA"
  memory_size_gb    = "${var.redis_storage_size}"
  redis_version     = "REDIS_4_0"
  reserved_ip_range = "${var.redis_ip_range}"

  region  = "${var.region}"
  project = "${google_project_service.redis.project}"
}

output "region" {
  value = "${var.region}"
}

output "redis_host" {
  value = "${google_redis_instance.memorystore.host}"
}

output "redis_port" {
  value = "${google_redis_instance.memorystore.port}"
}

output "google_project_id" {
  value = "${google_project.project.project_id}"
}
