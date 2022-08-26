provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "kinseyparham"

    workspaces {
      name = "aws-2tier-week20-project"
    }
  }
}