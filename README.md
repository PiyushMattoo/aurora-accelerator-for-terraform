## Aurora Accelerator for Terraform

Q: What is Aurora Accelerator for Terraform? 

A: Aurora Accelerator for Terraform is an open source GitHub solution that simplifies and automates intial setup and provisioning (day 1) and on-going maintainance (day 2) operations for Amazon Aurora. It's designed to remove heavy lifting required for AWS customers to migrate from commercial databases such as SQL Server to Amazon Aurora and operating these database in production.


Q: Who is the intended audience for Aurora Accelerator for Terraform? 

A: The intended audience for Aurora Accelerator for Terraform are AWS customers who are migrating from commercial databases such as SQL Server to Amazon Aurora.


Q: What are some of the key features of Aurora Accelerator for Terraform? 

A: Some of the key features of Aurora Accelerator for Terraform include automation of common tasks:
   1. Provisioning of new Aurora cluster
   2. Provisioning of new Aurora Global Database
   3. Monitoring Aurora database 
   	a. Amazon CloudWatch
   	b. Amazon Managed Grafana
	c. Curated CloudWatch and Grafana Dashboards
	d. Curated Performance Insights Dashboard for both CloudWatch and Grafana
   4. Provisiong and Integration with RDS Proxy
   5. Provisioning of Data Migration Services (DMS) Instances to migrate data to Aurora
   6. Restore cluster from S3


Q: Is there any cost associated with using Aurora Accelerator for Terraform? 

A: No, Aurora Accelerator for Terraform is an open-source solution and is completely free to use. However, you will be responsible for any AWS costs associated with running your Aurora clusters.


Q: Is there a community or support forum for Aurora Accelerator for Terraform? 

A: Yes, there is a community forum in GitHub where users can ask questions, share best practices, and provide feedback on Aurora Accelerator for Terraform. Terraform module for automating deployment of Amazon Aurora and related resources following AWS best practices.

Q. What DB Engines are currently supported?

A: Currently, we support below: 
    1. Aurora Provisioned cluster (PostgreSQL)
    2. Aurora Global databases (PostgreSQL)


# Terraform Modules

Here's how you can automate deployment of Amazon Aurora and related resources following AWS best practices.


## Deployment Procedure

To deploy the Terraform Amazon Aurora module, do the following:

1. Install Terraform. For instructions and a video tutorial, see [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

2. [Install](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) the AWS Command Line Interface (AWS CLI).

3. If you don't have git installed, [install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

4. Clone this ** awsdabra/aurora-accelerator-for-terraform** repository using the following command:

   `git clone https://github.com/awsdabra/aurora-accelerator-for-terraform.git`

5. Change directory to the root repository directory.

   `cd aurora-accelerator-for-terraform/`


6. Deploy Aurora Terraform module.
   1. To create VPC and deploy Aurora module
      - Initialize the deploy directory. Run `terraform init`.
      - Start a Terraform run using the configuration files (deploy.tf) in your deploy directory. 

7. The below demonstrates how you can leverage Aurora Blueprints to deploy an Aurora global cluster. Modify the paramaters below in the deploy.tf located in the top level folder. 

	a) Create a VPC with three availability zones (AZ) with a subnet in each AZ. 

	b) To use existing VPC subnet ids, update the locals below for the primary region and secondary region in the deploy.tf.   

	c) Also set the password to null to generate a new random password

	d) Update the data section with the subnet cidrs in the primary and secondary region. 

	e) Update the primary and secondary regions in the providers.tf file.  

	f) Run Terraform apply



