provider "aws" {
  shared_config_files      = ["/Users/ypreddy/.aws/conf"]
  shared_credentials_files = ["/Users/ypreddy/.aws/creds"]
  profile                  = "customprofile"
}



data "aws_subnet" "example" {
  for_each = toset(local.my_subnets)

  cidr_block = each.key
}

locals {
  my_subnets = ["10.1.101.0/24", "10.1.201.0/24"]
  subnet_ids = toset([
    for subnet in data.aws_subnet.example : subnet.id
  ])
}

module "aurora" {
  source = "./modules/tffiles-rds"
  # Aurora required fields
  subnets  			       = ["local.subnet_ids"] 
  enable_aurora			       = "true"
  environment			       = "dev"
  groupname			       = "dev"
  project			       = "dev"	 
  region			       = "useast1"
  name				       = "dev"
}
