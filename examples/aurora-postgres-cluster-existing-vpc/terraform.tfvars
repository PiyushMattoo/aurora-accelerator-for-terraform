
# (mandatory) AWS Region where your resources will be located
region = "us-east-2"

# (mandatory) VPC Id where your database and other AWS resources will be located. 
# For example: "vpc-0759280XX50555743"
vpc_id = "vpc-04d0cfc912221b272"

# (mandatory) Instance class. 
# For example: "db.t4g.micro" is a free tier instance 
instance_class ="db.t4g.micro"

# (mandatory) Database Engine for your Aurora Cluster. Options: "aurora-postgresql" or "aurora-mysql" 
engine = "aurora-postgresql"

# (optional) Default is provisioned database cluster; For serverless, select "serverless"
engine_mode = "provisioned"

# (optional) The database engine version. Updating this argument results in an outage"
engine_version = ""

# (optional) Database cluster name
name = "aurora-pg-poc"

# (optional) Database environment
environment = "dev"

# (optional) Tagging : Team/Group Name
groupname = "dev"

# (optional) Tagging : Project or Application Name
project = "dev"
