provider "aws" {
  region = local.region
}

data "aws_subnet_ids" "primary" {
  vpc_id = local.vpc_id
}

locals {
  region         = var.region
  vpc_id         = var.vpc_id
  name           = var.name
  engine         = var.engine
  engine_mode    = var.engine_mode
  instance_class = var.instance_class
  environment    = var.environment
  groupname      = var.groupname
  project        = var.project
  tags        = {
                  Name = local.name
                  GroupName = local.groupname
                  Environment = local.environment
                  Project = local.project
                }
}

# deploy aurora database cluster
module "aurora_poc" {
    source = "../../modules/tffiles-rds"
    instance_class  = local.instance_class 
    region	    = local.region
    vpc_id      = local.vpc_id
    subnets    = tolist(data.aws_subnet_ids.primary.ids)
    engine      = local.engine
    engine_mode = local.engine_mode
    name		    = local.name
    environment	= local.environment
    groupname	  = local.groupname
    project	    = local.project
    tags        = local.tags
}
