terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC 및 네트워킹
module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

# ALB (Application Load Balancer)
module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  public_subnets        = module.vpc.public_subnets
  alb_security_group_id = module.vpc.alb_security_group_id
  environment           = var.environment
}

# S3 Bucket for React static files
module "s3" {
  source         = "./modules/s3"
  environment    = var.environment
  cloudfront_oai = "placeholder" # 임시 값, 나중에 업데이트
}

# CloudFront CDN
module "cloudfront" {
  source                         = "./modules/cloudfront"
  environment                    = var.environment
  alb_domain_name                = module.alb.alb_dns_name
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

# EC2 Instances for Spring Boot Application
module "ec2" {
  source                = "./modules/ec2"
  environment           = var.environment
  aws_region            = var.aws_region
  instance_type         = var.instance_type
  ec2_security_group_id = module.vpc.ec2_security_group_id
  private_subnets       = module.vpc.private_subnets
  target_group_arn      = module.alb.target_group_arn
  ssh_public_key        = var.ssh_public_key
  db_endpoint           = module.rds.db_endpoint
  db_name               = var.db_name
  db_username           = var.db_username
  desired_capacity      = var.desired_capacity
  max_size              = var.max_size
  min_size              = var.min_size
}



# RDS MySQL
module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  ec2_security_group_id = module.vpc.ec2_security_group_id
  environment           = var.environment
  db_password           = var.db_password
}

# CloudWatch
module "cloudwatch" {
  source      = "./modules/cloudwatch"
  environment = var.environment
  asg_name    = module.ec2.asg_name
  alb_name    = module.alb.alb_name
}
