####################
## ubuntu-2004
####################

# define image to use
data "google_compute_image" "ubuntu_2004" {
  project = "ubuntu-os-cloud"
  name    = "ubuntu-2004-focal-v20220823"
}
