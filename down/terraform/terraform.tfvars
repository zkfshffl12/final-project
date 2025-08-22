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
db_password = "GameServer2024!@#$%^&*()_+-=[]{}|;:,.<>?"

# EC2 Configuration
instance_type = "t3.medium"

# SSH Public Key (REPLACE WITH YOUR SSH PUBLIC KEY)
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKwJ8F2lmRzxkdSfGGk8J9Np7w5c1x4E3mF6H7J8qK9Lm0NpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz1AbCdEf2GhIj3KlMnOpQrStUvWxYz terraform@aws.com"

# Database Configuration
db_name     = "gamedb"
db_username = "admin"

# Auto Scaling Group Configuration
desired_capacity = 2
max_size         = 4
min_size         = 1
