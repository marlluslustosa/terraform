# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = "${file("credentials.json")}"
project = "stoked-droplet-192316"
//region = "us-central1"
region = "us-east4"
}
