data "aws_subnet" "primary" {
  for_each = toset(local.my_primary_subnets)
  cidr_block = each.key
}

data "aws_subnet" "secondary" {
  for_each = toset(local.my_secondary_subnets)
  cidr_block = each.key
}


locals {
  my_primary_subnets = ["10.1.101.0/24", "10.1.201.0/24"]
  my_secondary_subnets = ["10.1.101.0/24", "10.1.201.0/24"]
  primary_subnet_ids = toset([
    for subnet in data.aws_subnet.primary : subnet.id
  ])
  secondary_subnet_ids = toset([
    for subnet in data.aws_subnet.secondary : subnet.id
  ])
}

module "auroraglobal" {
	source = "./modules/tffiles-aurora-global"
        private_subnet_ids_s = ["local.primary_subnet_ids"]
        private_subnet_ids_p = ["local.secondary_subnet_ids"]
	#set setup_globaldb to true if you want to create an Aurora global DB cluster spread across 2 AWS Regions
	setup_globaldb = true

	# Set up aws_rds_cluster.primary Terraform resource as secondary Aurora cluster after an unplanned Aurora global DB failover (detach and promote of the secondary Region)

	# If you are setting up a brand new Aurora global cluster, set the setup_as_secondary variable to false
	setup_as_secondary = false

	#set storage_encrypted to true to enable Aurora storage encryption using AWS KMS
	storage_encrypted = true

	# Number of instances to set up for primary Aurora cluster
	primary_instance_count = 2
}
#module "aurora" {
#  source = "./modules/tffiles-rds"
  # End boolean values 
#  subnets  			          = ["local.subnet_ids"] 
#  environment			        = "dev"
#  groupname			          = "dev"
#  project			            = "dev"	 
#  region			            = "us-east-1"
#  name				            = "dev"
#}

#module "dbproxy" {
#  source = "./modules/tffiles-dbproxy"
  # dbproxy required fields
#  enable_dbproxy          = "false" 
#  name                    = "devdbproxy"
#  environment             = "dev"
#  region                  = "us-east-1"
#  groupname               = "dev"
#  project                 = "dev"
#  vpc_security_group_ids  = ["dev"]
#  subnets	          = ["local.subnet_ids"]
#}

#module "lambda" {
 # source = "./modules/tffiles-lambda"
  # lambda required fields
  #enable_lambda          = "true" 
  #region                 = "us-east-1"
  #subnet_ids             = ["local.subnet_ids"]
  #vpc_id                 = "dev"
  #environment            = "dev" 
  #groupname              = "dev"
  #project                = "dev"
  #s3_key                 = "dev"
  #secret_name            = "dev"
  #name                   = "dev"
  #s3_bucket              = "dev"
  #iam_role               = "dev"  
#}

#module "route53" {
#  source = "./modules/tffiles-route53"
#  # route53 required fields
#  enable_route53          = "false"
#  internal_read_endpoint  = "dev"
#  internal_write_endpoint = "dev"
#  read_endpoint           = "dev"
#  write_endpoint          = "dev"
#  domain                  = "dev" 
#  region                  = "us-east-1" 
#}
