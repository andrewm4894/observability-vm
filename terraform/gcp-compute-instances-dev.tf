########################################
# dev
########################################
#/*
# make a static ip to use for this vm
resource "google_compute_address" "dev" {
  name = "dev"
}

# define the instance
resource "google_compute_instance" "dev" {
  name                      = "dev"
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
      nat_ip = google_compute_address.dev.address
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }
  metadata_startup_script = templatefile("scripts/dev.sh", {
    prepare : templatefile("scripts/src/prepare.sh", {
      dummy-secret : data.google_secret_manager_secret_version.dummy_secret_read.secret_data
    }),
    #install-node : file("scripts/src/install-node.sh"),
    #install-yarn : file("scripts/src/install-yarn.sh"),
    #install-gh : templatefile("scripts/src/install-gh.sh", {
    #    gh-token : var.gh_token
    #}),
    #install-stress-ng : file("scripts/src/install-stress-ng.sh"),
    #install-docker : file("scripts/src/install-docker.sh"),
    install-netdata : templatefile("scripts/src/install-netdata.sh", {
      netdata-fork : "andrewm4894/netdata",
      netdata-branch : "add-alerts-python-collector",
      netdata-claim-token : var.netdata_claim_token,
      #netdata-claim-token : "foo",
      netdata-claim-url : var.netdata_claim_url,
    }),
    #install-netdata-fe : templatefile("scripts/src/install-netdata-fe.sh", {
    #  netdata-charts-branch : "main",
    #  netdata-cloud-frontend-branch : "telemetry-pipeline",
    #  gh-token : var.gh_token
    #}),
  })
}
#*/
