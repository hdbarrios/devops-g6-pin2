# General:
aws_region                = "us-east-1"
#aws_profile               = "terraform-admin"
availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
tags                      = {
    repositorio = "git@github.com:hdbarrios/devops-g6-pin2.git"
    proyecto    = "PIN2"
    equipo      = "Grupo6"
    environment = "test"
}

# VPC:
vpc_cidr                  = "10.11.0.0/16"
private_subnet_cidrs      = ["10.11.10.0/24", "10.11.20.0/24"]
public_subnet_cidrs       = ["10.11.1.0/24", "10.11.30.0/24"]
ssh_cidr                  = ["0.0.0.0/0", "10.11.1.0/24"]
create_private_subnet     = true
create_public_subnet      = true

# EC2:
ec2_ami                   = "ami-0e2c8caa4b6378d8c"   # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
ec2_storage_type          = "gp2"
ec2_storage               = 40   # Tamaño del volumen en GB
ec2_instance_type         = "t2.micro"
ec2_name                  = "ec2-apache-pin2"
key_name                  = "apache-key"

