resource "google_project" "my_project" {
  name       = "My Project"
  project_id = "your-project-id"
  org_id     = "1234567"
}

resource "google_app_engine_application" "app" {
  project     = google_project.my_project.project_id
  location_id = "us-central"
}



resource "google_app_engine_application_url_dispatch_rules" "web_service" {
  dispatch_rules {
    domain  = "*"
    path    = "/*"
    service = "default"
  }

  dispatch_rules {
    domain  = "*"
    path    = "/admin/*"
    service = google_app_engine_standard_app_version.admin_v3.service
  }
}

resource "google_app_engine_standard_app_version" "admin_v3" {
  version_id = "v3"
  project = ""
  service    = "admin"
  runtime    = "nodejs10"

  entrypoint {
    shell = "node ./app.js"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.object.name}"
    }
  }

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
  type = ""
  source_dir = ""
  output_path = ""
}

resource "google_storage_bucket" "bucket" {
    project = ""
    name     = "appengine-test-bucket"
    location = "US"
    force_destroy = true
}

resource "google_storage_bucket_object" "object" {
    name   = "hello-world.zip"
    bucket = google_storage_bucket.bucket.name
    source = "./test-fixtures/hello-world.zip"
}