# AWS Region
aws_region = "us-east-1"

# Environment
environment = "production"

# VPC CIDR
vpc_cidr = "10.0.0.0/16"

# Application name
app_name = "game-server"

# Domain name for CloudFront
domain_name = "your-domain.com"

# Database password (REPLACE WITH YOUR SECURE PASSWORD)
db_password = "GameServer2024!"

# EC2 Configuration
instance_type = "t3.medium"

# SSH Public Key (REPLACE WITH YOUR SSH PUBLIC KEY)
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDk1V1fFLANnf/96fbBvhfIpcf+61vtjzjlDY9RhBHC7jSd4Q0D7DTUtzLOS2+wH46Nm+FaT+7CBOiu9hpNfegAeHQg/d8AKFxj1h7yKNqu4vZgnKI+y9bpTjSpwHn7YjEy1xhrClEe1VwbpZPP2DWjBt5wBTIySY9b9bU3M6f0Zbob8HUV/S6GXQd+4oQBLevB+MeKH803+HBE18cN3lQaT6/oQBLreJZVo5EkbIeH8D6JC0FdK1/rT+C0J57t+5v1k40MfdplnGPYUNXXHTfRO93xo1hrk8ENbec1QIEJr06nzwpjjKXrDSq/vlQhB1JZjWPN3O0HLIHGekq+k3VooxOFDEomIaWC/H6/1OeRO97GF4hOSUJEFGhtp2AZQ6ZbWWiNNt1Bo7m/8HrVk8uLD/yeHIbRI2z229XMuWxcxHxBHqga3Zisdm2hX5uOOQ/OwUMg2Kvocckj+f/cxBKWpinG5jZ4TdrM+JuSw6YH6txZQBNHmx4Mw0p2mVVdFVpZ1LaG4LMAOBFYxn+y49/PDrOvVU+ONzAe/j1PKmiRwJVzxsNpsp39kI2O5jMTwiBCieGlaLqcSvVfFO1MylojMk+U+A7VecelqPoR6Hbjs7OdAKIiMnwKrjCd0Ao4F5qQPJ3Ui1TYXfpxDOokTmesJFa7qIJDSOiVm3+JXa5gOw== edu03-02@EDU01-10"

# Database Configuration
db_name = "gamedb"
db_username = "admin"

# Auto Scaling Group Configuration
desired_capacity = 2
max_size = 4
min_size = 1
