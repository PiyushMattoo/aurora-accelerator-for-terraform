# aurora-accelerator-for-terraform
Aurora Blueprint to Accelerate Day 2 ops using Terraform

1. Modify variables in deploy.tf for each module 
2. Terraform init 
3. Terraform plan 
4. Terraform apply 

## Usage

The below demonstrates how you can leverage Aurora Blueprints to deploy an Aurora global cluster. Modify the paramaters below in the deploy.tf located in the top level folder 

```hcl
module "auroraglobal" {
	source = "./modules/tffiles-aurora-global" 
        sec_region = "null"
        Private_subnet_ids_s = ["local.subnet_ids"]
        region = "null"
        Private_subnet_ids_p = ["local.subnet_ids"]
        password = "null"
	      #set setup_globaldb to true if you want to create an Aurora global DB cluster spread across 2 AWS Regions
	      setup_globaldb = true

	      # Set up aws_rds_cluster.primary Terraform resource as secondary Aurora cluster after an unplanned Aurora global DB failover (detach and promote of         the secondary Region)

	      # If you are setting up a brand new Aurora global cluster, set the setup_as_secondary variable to false
	      setup_as_secondary = false

	      #set storage_encrypted to true to enable Aurora storage encryption using AWS KMS
	      storage_encrypted = true

	      # Number of instances to set up for primary Aurora cluster
	      primary_instance_count = 2
}
```

