output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.distribution_domain_name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket for static files"
  value       = module.s3.bucket_name
}

output "s3_website_endpoint" {
  description = "The S3 website endpoint"
  value       = module.s3.website_endpoint
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = module.ec2.instance_private_ip
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.ec2.asg_name
}

output "key_pair_name" {
  description = "The name of the key pair"
  value       = module.ec2.key_pair_name
}



output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_endpoint
}

output "rds_database_name" {
  description = "The name of the database"
  value       = module.rds.db_name
}

output "rds_username" {
  description = "The master username for the database"
  value       = module.rds.db_username
}

output "cloudwatch_dashboard_name" {
  description = "The name of the CloudWatch dashboard"
  value       = module.cloudwatch.dashboard_name
}

# ECS Outputs
output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = module.ecs.service_id
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}
