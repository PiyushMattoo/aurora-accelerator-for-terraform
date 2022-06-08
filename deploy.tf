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
  # Start boolean values as true, false
  create_cluster                        = "true"
  create_random_password                = "true"
  #"Determines whether cluster is primary cluster with writer instance (set to `false` for global cluster and replica clusters)"
  is_primary_cluster                    = "true" 
  #"Whether cluster should forward writes to an associated global cluster. Applied to secondary clusters to enable them to forward writes to an `aws_rds_global_cluster`'s primary cluster"
  enable_global_write_forwarding        = "false" 
  allow_major_version_upgrade           = "false"
  skip_final_snapshot                   = "false"
  deletion_protection                   = "false" 
  storage_encrypted                     = "true" 
  apply_immediately                     = "false"
  iam_database_authentication_enabled   = "false"
  iam_role_force_detach_policies        = "false"
  instances_use_identifier_prefix       = "false"
  publicly_accessible                   = "false"
  auto_minor_version_upgrade            = "false"
  performance_insights_enabled          = "false"
  iam_role_use_name_prefix              = "false"
  copy_tags_to_snapshot                 = "false"
  enable_http_endpoint                  = "false"
  create_db_subnet_group                = "true"
  create_monitoring_role                = "true"
  monitoring_interval                   = "0"
  autoscaling_enabled                   = "false"
  create_security_group                 = "true"
  security_group_egress_rules           = {}
  # End boolean values 
  subnets  			          = ["local.subnet_ids"] 
  environment			        = "dev"
  groupname			          = "dev"
  project			            = "dev"	 
  region			            = "us-east-1"
  name				            = "dev"
}

module "dbproxy" {
  source = "./modules/tffiles-dbproxy"
  # dbproxy required fields
  enable_dbproxy          = "true" 
  name                    = "devdbproxy"
  environment             = "dev"
  region                  = "us-east-1"
  groupname               = "dev"
  project                 = "dev"
  vpc_security_group_ids  = ["dev"]
  subnets	          = ["local.subnet_ids"]
}

module "lambda" {
  source = "./modules/tffiles-lambda"
  # lambda required fields
  enable_lambda          = "true" 
  region                 = "us-east-1"
  subnet_ids             = ["local.subnet_ids"]
  vpc_id                 = "dev"
  environment            = "dev" 
  groupname              = "dev"
  project                = "dev"
  s3_key                 = "dev"
  secret_name            = "dev"
  name                   = "dev"
  s3_bucket              = "dev"
  iam_role               = "dev"  
}

module "route53" {
  source = "./modules/tffiles-route53"
  # route53 required fields
  enable_route53          = "true"
  internal_read_endpoint  = "dev"
  internal_write_endpoint = "dev"
  read_endpoint           = "dev"
  write_endpoint          = "dev"
  domain                  = "dev" 
  region                  = "us-east-1" 
}

