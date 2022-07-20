## Terraform Amazon Aurora

Terraform module for automating deployment of Amazon Aurora and related resources following AWS best practices.
Supported Features

    Aurora Provisioned cluster (MySQL & PostgreSQL)
    Aurora Global databases (MySQL & PostgreSQL)

# Terraform Amazon Aurora
Terraform module for automating deployment of Amazon Aurora and related resources following AWS best practices.

## Supported Features
- Aurora Provisioned cluster (MySQL & PostgreSQL)
- Aurora Global databases (MySQL & PostgreSQL)

## Deployment Procedure

To deploy the Terraform Amazon Aurora module, do the following:

1. Install Terraform. For instructions and a video tutorial, see [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. Sign up and log into [Terraform Cloud](https://www.terraform.io/cloud) (There is a free tier available).
   1.  Create a [Terraform organization](https://www.terraform.io/docs/cloud/users-teams-organizations/organizations.html#creating-organizations).

3. Configure [Terraform Cloud API access](https://learn.hashicorp.com/tutorials/terraform/cloud-login). Run the following to generate a Terraform Cloud token from the command line interface:
   ```
   terraform login

   --For Mac/Linux
   export TERRAFORM_CONFIG="$HOME/.terraform.d/credentials.tfrc.json"

   --For Windows
   export TERRAFORM_CONFIG="$HOME/AppData/Roaming/terraform.d/credentials.tfrc.json"
   ```

4. [Install](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) the AWS Command Line Interface (AWS CLI).

5. If you don't have git installed, [install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

6. Clone this **aws-ia/terraform-aws-rds-aurora** repository using the following command:

   `git clone https://github.com/aws-ia/terraform-aws-rds-aurora.git`

7. Change directory to the root repository directory.

   `cd terraform-aws-rds-aurora/`

8. Set up a new terraform workspace.
   
   ```
   cd setup_workspace
   terraform init
   terraform apply
   ```

9. Deploy Aurora Terraform module.
   1. To create VPC and deploy Aurora module
      - Change to the deploy directory. Run `cd ../deploy`
      - Initialize the deploy directory. Run `terraform init`.
      - Start a Terraform run using the configuration files in your deploy directory. Run `terraform apply`  or `terraform apply -var-file="$HOME/.aws/terraform.tfvars"` (Note: The deployment is remotely run in Terraform Cloud)
   2. To deploy Aurora module into existing VPCs, pass the list of private subnets (var.Private\_subnet\_ids\_p & var.Private\_subnet\_ids\_s) directly to the Aurora module.


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

	# Set up aws_rds_cluster.primary Terraform resource as secondary Aurora cluster after an unplanned Aurora global DB failover (detach and                   promote of the secondary Region)

        # If you are setting up a brand new Aurora global cluster, set the setup_as_secondary variable to false
        setup_as_secondary = false

        #set storage_encrypted to true to enable Aurora storage encryption using AWS KMS
        storage_encrypted = true

        # Number of instances to set up for primary Aurora cluster
        primary_instance_count = 2
}
```

```hcl
cd modules/tffiles-aurora-global
Open variables.tf using vi 

