resource "google_project" "my_project" {
  name       = "ProjectCloudDevOps"
  project_id = var.PROJECT_ID
}

resource "google_app_engine_application" "node_app" {
  project     = var.PROJECT_ID
  location_id = var.REGION
}

resource "google_app_engine_application_url_dispatch_rules" "app-dispatch-rules" {
  dispatch_rules {
    domain  = "*"
    path    = "/*"
    service = "default"
  }

resource "google_app_engine_standard_app_version" "admin_v3" {
  version_id = "v2"
  project = var.PROJECT_ID
  service    = "admin"
  runtime    = "nodejs10"

  entrypoint {
    shell = "node app.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.object.name}"
    }
  }

  instance_class = "F1"

   env_variables = {
    port = "8080"
  }

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances = 1
    max_idle_instances = 3
    min_pending_latency = "1s"
    max_pending_latency = "5s"
    standard_scheduler_settings {
      target_cpu_utilization = 0.5
      target_throughput_utilization = 0.75
      min_instances = 2
      max_instances = 10
    }
  }
  
  delete_service_on_destroy = true
  noop_on_destroy = true
}

data "archive_file" "archive_dist" {
  type = "zip"
  source_dir = "../app"
  output_path = "../app/app.zip"
}

resource "google_storage_bucket" "bucket" {
    project = var.PROJECT_ID
    name     = var.BUCKET_PROJECT
    location = var.REGION
    force_destroy = true
}

resource "google_storage_bucket_object" "object" {
    name   = "app.zip"
    bucket = google_storage_bucket.bucket.name
    source = data.archive_file.archive_dist.output_path
}
