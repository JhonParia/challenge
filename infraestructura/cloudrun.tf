resource "google_cloud_run_service" "api" {
  name     = "api-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "pub" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location = google_cloud_run_service.api.location
  project = google_cloud_run_service.api.project
  service = google_cloud_run_service.api.name
  policy_data = data.google_iam_policy.pub.policy_data
}