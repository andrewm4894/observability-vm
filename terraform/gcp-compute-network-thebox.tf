####################
## thebox
####################

# make network
resource "google_compute_network" "thebox" {
  name = "thebox"
}

# create firewall rules
resource "google_compute_firewall" "thebox_allow_ssh" {
  name    = "thebox-allow-ssh"
  network = google_compute_network.thebox.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # ip's to whitelist
  source_ranges = var.thebox_ip_whitelist
}

# create firewall rules to allow some ports
resource "google_compute_firewall" "thebox_allow" {
  name    = "thebox-allow"
  network = google_compute_network.thebox.name
  allow {
    protocol = "tcp"
    ports = [
      "19999", # netdata
      #"8086",  # influxdb
      #"3000",  # grafana     
      #"9090",  # prometheus
      #"9100",  # node_exporter
      #"8080",  # opentelemetry demo app
      #"5601", # kibana
      #"9600", # logstash
      #"9200", # elasticsearch
      #"25565", # mincraft
      #"32400", # plex
      #"9000", # portainer
    ]
  }
  # ip's to whitelist
  source_ranges = var.thebox_ip_whitelist
}
