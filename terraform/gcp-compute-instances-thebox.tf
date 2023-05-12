########################################
# thebox
########################################

# make a static ip to use for this vm
resource "google_compute_address" "thebox" {
  name = "thebox"
}

#/*
# define the instance
resource "google_compute_instance" "thebox" {
  name                      = "thebox"
  machine_type              = "n1-standard-2"
  zone                      = var.gcp_zone
  tags                      = ["dev"]
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_2004.self_link
      size  = 100
      type  = "pd-standard"
    }
  }
  network_interface {
    network = google_compute_network.thebox.name
    access_config {
      nat_ip = google_compute_address.thebox.address
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }
  metadata_startup_script = templatefile("scripts/thebox.sh", {
    prepare : templatefile("scripts/src/prepare.sh", {
      dummy-secret : data.google_secret_manager_secret_version.dummy_secret_read.secret_data
    }),
    install-docker : file("scripts/src/install-docker.sh"),
    install-netdata : templatefile("scripts/src/install-netdata.sh", {
      netdata-claim-token : var.netdata_claim_token
    }),
    /*
    install-prometheus : file("scripts/src/install-prometheus.sh"),
    install-grafana : templatefile("scripts/src/install-grafana.sh", {
      grafana-password : var.grafana_password
    }),
    install-datadog : templatefile("scripts/src/install-datadog.sh", {
      datadog-api-key : var.datadog_api_key,
      datadog-site : var.datadog_site,
    }),
    install-google-ops-agent : file("scripts/src/install-google-ops-agent.sh"),
    install-influxdb : templatefile("scripts/src/install-influxdb.sh", {
      influxdb-user : var.influxdb_user,
      influxdb-password : var.influxdb_password,
      influxdb-token : var.influxdb_token,
      influxdb-org : var.influxdb_org,
      influxdb-bucket : var.influxdb_bucket,
    }),
    install-telegraf : file("scripts/src/install-telegraf.sh"),
    configure-influxdb : templatefile("scripts/src/configure-influxdb.sh", {
      influxdb-token : var.influxdb_token,
      influxdb-org : var.influxdb_org,
      influxdb-bucket : var.influxdb_bucket,
    }),
    */
    configure-cronjobs : file("scripts/src/configure-cronjobs.sh"),
    /*
    install-akita : templatefile("scripts/src/install-akita.sh", {
      akita-api-key : var.akita_api_key,
      akita-api-secret : var.akita_api_secret,
    }),
    deploy-opentelemetry-demo-app : file("scripts/src/deploy-opentelemetry-demo-app.sh"),
    */
  })
}
#*/
