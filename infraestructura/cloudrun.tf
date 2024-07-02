resource "google_cloud_run_service" "api" {
  name     = "api-srv"
  location = "us-central1"

  template {
    spec {
      containers {
        ports {
          container_port = 5000
        }
        image = "us-central1-docker.pkg.dev/latam-challenge-427922/latam-challenge/challenge:latest"
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