########################################
## dummy_secret
########################################

# create the secret
resource "google_secret_manager_secret" "dummy_secret" {
  secret_id = "dummy_secret"
  replication {
    automatic = true
  }
}

# create a version in the secret
resource "google_secret_manager_secret_version" "dummy_secret" {
  secret = google_secret_manager_secret.dummy_secret.id
  # define the secret value
  secret_data = var.dummy_secret
}
