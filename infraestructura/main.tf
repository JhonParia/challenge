resource "google_pubsub_topic" "mi_topico" {
  name = "bq-topic"
}
resource "google_pubsub_subscription" "bq_suscripcion" {
  name  = "bq-subscription"
  topic = google_pubsub_topic.mi_topico.id

  message_retention_duration = "86400s" # 1 day in seconds

  ack_deadline_seconds = 20

  bigquery_config {
    table = "${google_bigquery_table.my_table.project}.${google_bigquery_table.my_table.dataset_id}.${google_bigquery_table.my_table.table_id}"
    use_table_schema = true
  }

  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}

data "google_project" "project" {
}

resource "google_project_iam_member" "viewer" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.metadataViewer"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "latam_dataset"
  location                    = "US"
  delete_contents_on_destroy  = false
}

resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "mi_tabla"
  deletion_protection = false
  schema = <<EOF
[
  {
    "name": "id",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "title",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "description",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF
}



