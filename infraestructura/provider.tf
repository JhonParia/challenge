provider "google" {
  credentials = file("../latamSA.json")
  project     = "latam-challenge-427922"
  region      = "us-central1"
}