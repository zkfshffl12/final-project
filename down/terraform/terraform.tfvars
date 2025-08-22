# AWS Region
aws_region = "us-east-1"

# Environment
environment = "production-v2"

# VPC CIDR
vpc_cidr = "10.0.0.0/16"

# Application name
app_name = "game-server"

# Domain name for CloudFront
domain_name = "your-domain.com"

# Database password (REPLACE WITH YOUR SECURE PASSWORD)
db_password = "GameServer2024!#$%^&*()"

# EC2 Configuration
instance_type = "t3.medium"

# SSH Public Key (REPLACE WITH YOUR SSH PUBLIC KEY)
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGd1JHkCim1lnYUfMezQ7bl0UA1479NRZjXyLGqQilcESW398+ekrgPD/ua5rgImoTlVf2f9tqfYp5FVAAciESfos1nf8Z5Pykc05BKQvm3PqICVZNP6ie6YS0u4ps0oWKbzvIYsKF6L0UuJtpMAZ7DNkozJ1M8iRr0lxY18IMOykO1sjsAXqlUrHZqMlwYFx5wEFhzL7pZKoHtcVg8ppdoxcIviO40ZYMl0Fw3KN5TMOxXBDue3OZk3bfTDGJCXxt9pq/+kFtCRUCztNbGr0SGGL74gEZKns3xco70K2Leof4V42STdKL8oHzT7Pg1HH6QqwNtRCscZhEMLmaMdC6+5KuNxqr6BdOw6wB3EAEs8jDrD/zX9LCVlJRzEnQx1LaCGAhefKMtnJvXQD/BJeE6KenG0VIverpV8oZQJT/pnJ778z0126703FY0vLD2x6Wcd7KPmBR4NJ+fe81iQnBA0bh1l6j9eN9iU0zrM/8y8S8Roxvd3Yv2z0UlLr5V3bY3ZRxlQ2sUwIoNcU4L91vH4PpMlFOoA+Cii71ufrj878dGN3gW9zpVVJZrkiMxj3gAL38TH4Do7aqbowOgiI6Nzb51Dwp6r3PgA9P1l47RTq1LYD+v0YCdjNFJfh2bL22ERnlMdOHKGtqI2MTkExQ4bsOex7F1EiTpvw0BUIZmQ== terraform@aws.com"

# Database Configuration
db_name     = "gamedb"
db_username = "admin"

# Auto Scaling Group Configuration
desired_capacity = 2
max_size         = 4
min_size         = 1
