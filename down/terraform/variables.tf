variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "game-server"
}

variable "domain_name" {
  description = "Domain name for CloudFront"
  type        = string
  default     = "your-domain.com"
}

variable "db_password" {
  description = "Database password for RDS MySQL"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "ssh_public_key" {
  description = "SSH public key for EC2 access"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "gamedb"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

# ECS Variables
variable "container_image" {
  description = "Container image URI for ECS"
  type        = string
  default     = "ghcr.io/zkfshffl12/final-project:latest"
}

variable "container_port" {
  description = "Container port for ECS"
  type        = number
  default     = 3000
}

variable "task_cpu" {
  description = "Task CPU units for ECS"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Task memory in MiB for ECS"
  type        = number
  default     = 512
}

variable "service_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "certificate_arn" {
  description = "SSL certificate ARN for HTTPS"
  type        = string
  default     = ""
}
