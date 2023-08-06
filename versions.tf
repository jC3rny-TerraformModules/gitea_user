
terraform {
  required_providers {
    gitea = {
      source  = "Lerentis/gitea"
      version = "~> 0.16.0"
    }
    #
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }

  required_version = "~> 1.5.0"
}
