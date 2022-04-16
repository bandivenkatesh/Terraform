provider "google" {
  project     = "productionproject-2222"
  region      = "us-central1"
  credentials = file("productionproject-2222-2136743f530f.json")
}

# Create a Virtual Private Cloud (VPC)
resource "google_compute_network" "tf_vpc" {
  name = "terraform-vpc"
}

resource "google_compute_network" "tf_vpcc" {
  name = "terraform-vpcc"
  auto_create_subnetworks = false
}

# Create a subnet in terraform-vpcc 
resource "google_compute_subnetwork" "tf_subnet_custom_a" {
    name = "subnet-abc"
    # Region, CIDR range , Network 
    region        = "us-central1"
    ip_cidr_range = "10.2.0.0/16"
    network      = google_compute_network.tf_vpcc.id
}

#gcloud compute networks create terraform-vpc 

#######

# Create a VM using terraform douctmentation

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

