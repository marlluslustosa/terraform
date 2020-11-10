# Configure the XenServer Provider
provider "xenorchestra" {
  # Must be ws or wss
  url      = "ws://ip" # Or set XOA_URL environment variable
  username = "user"              # Or set XOA_USER environment variable
  password = "pass"              # Or set XOA_PASSWORD environment variable
}

terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
      version = "~> 0.5"
    }
  }
}
