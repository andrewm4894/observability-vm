####################
## mynetwork
####################

# make network
resource "google_compute_network" "mynetwork" {
  name = "mynetwork"
}

# create firewall rules
resource "google_compute_firewall" "mynetwork_allow_ssh" {
  name    = "mynetwork-allow-ssh"
  network = google_compute_network.mynetwork.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # ip's to whitelist
  source_ranges = var.mynetwork_ip_whitelist
}

# create firewall rules to allow some ports
resource "google_compute_firewall" "mynetwork_allow" {
  name    = "mynetwork-allow"
  network = google_compute_network.mynetwork.name
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
  source_ranges = var.mynetwork_ip_whitelist
}
