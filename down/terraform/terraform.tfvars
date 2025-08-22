# AWS Region
aws_region = "us-east-1"

# Environment
environment = "production-new"

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
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHyiviqN2z5WYE/2HM8JlWYqCuQIZy5CojXzzryzfK7yqibA9fHxX6rhHCJJFp96Ldl7Ywma8alaWBmQIKRlyi29L9FyE7b8LvwWpIZcd0OtemCfUImJglCG0GLrcFAA/eoHsmtOkHjjMsziaeQSfHjsAk2QCXYIjg5QgapZryzVGdV/s1fdS9WV9Geb7ezh+st11/SVDJCUPn6+9x+r/8pU48EtceB79F8YZLPe4ytqISY8UfDl7zhviNl0yaCdOXlMyDcME/e/aFo2gdCwTDTtIzQDNcq09hqrKi1pMhE+cuoYIoTdGmSsDJVZOQUrP2jkL339DWphApcsBqsihCKZSGwWIPU/dWl7DyXqH0iMM/3HR9zbffdTWLPSww+9IwXUlx2kLVigl/hK9usEQLzbxz2Fibg8vyJ2DYsC4WRK4mMGi0gu2kVglTvzi2iq3vCIQO+wZCvp9wpYtxYMSAeJe2RdNn4jWMZUHbyvtA2fcMZWOP6WXrA+k30W4KxesPlsH/4IpDZ4N6dVIAo68+vgvQtZi5gRmU62U2FDlrosP4Q3dBXqsL9mDspHNzPQhIQ2sfb6UjQunvtZ8uGKccUp8ryqa6+MPjt/ZzWJGApu7Z5vXfYDM3uE+y85AE2idJO0Wspu4GDwJGUlcnr6pwZHs9CzWbQFur7USiMnHBTw== sbskv@anheebin"

# Database Configuration
db_name = "gamedb"
db_username = "admin"

# Auto Scaling Group Configuration
desired_capacity = 2
max_size = 4
min_size = 1
