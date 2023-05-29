########################################
# ml-demo-ml-enabled-mldefaults24h
########################################
/*
# make a static ip to use for this vm
resource "google_compute_address" "ml_demo_ml_enabled_mldefaults24h" {
  name = "ml-demo-ml-enabled-mldefaults24h"
}

# define the instance
resource "google_compute_instance" "ml_demo_ml_enabled_mldefaults24h" {
  name                      = "ml-demo-ml-enabled-mldefaults24h"
  machine_type              = "n1-standard-1"
  zone                      = var.gcp_zone
  tags                      = ["dev"]
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_2004.self_link
      size  = 20
      type  = "pd-standard"
    }
  }
  network_interface {
    network = google_compute_network.mynetwork.name
    access_config {
      nat_ip = google_compute_address.ml_demo_ml_enabled_mldefaults24h.address
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }
  metadata_startup_script = templatefile("scripts/ml-demo-ml-enabled-mldefaults24h.sh", {
    prepare : templatefile("scripts/src/prepare.sh", {
      dummy-secret : data.google_secret_manager_secret_version.dummy_secret_read.secret_data
    }),
    install-stress-ng : file("scripts/src/install-stress-ng.sh"),
    install-docker : file("scripts/src/install-docker.sh"),
    install-netdata : templatefile("scripts/src/install-netdata.sh", {
      netdata-fork : "andrewm4894/netdata",
      netdata-branch : "ml-defaults-24h",
      netdata-claim-token : var.netdata_claim_token,
      netdata-claim-url : "https://app.netdata.cloud"
    }),
    configure-cronjobs : file("scripts/src/configure-cronjobs.sh"),
  })
}
*/
