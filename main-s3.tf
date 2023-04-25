locals {
  region = "ap-southeast-1"
}

provider "aws" {
  region = local.region
}

module "s3_digital_sign" {
  source       = "./modules"
  department   = "home"
  environment  = "test"
  project_name = "digital-sign"
  role         = ""
}
