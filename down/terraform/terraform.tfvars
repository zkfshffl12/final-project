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
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7VJTUt9UsQcK1BzEiPYDd6t3vqtxniIgqbbotgMhdgMWLt1nVyHOMtZ0eRsswu4vnBbrngUQt5qgQ6bbb6qu1UoPTPjH5Eh5TtahVAqcCJcidt28wRBR8PVmc3nzsJpV8RtzSUaLthltR54FJb1ac7mgQ3Y49qKhCg2E9uEVB77GxqItKzLtl1zNk3j35Tvs7XeorfGOWHI1aBfKsl1DSipNXKmoD5LxscyMNpS08NgKEjso4MgiuqjSG4bCAb6WH7JaYvTrrFP28J6weGqOU1pt5vu2W915RzKiKriZEOJz4RZQV5ZapUuaBvZ4R6LIdZRjTcexJD8r145RtbSUkbZkD4U3qGxclMp7wLtsFZ7GvYdSyyT0afH8Al4fmfb7s1s2j9Kz1HGS1mZo2StTQaOVPZ5Xv6kmWg9e4rKQraWP4w terraform@example.com"

# Database Configuration
db_name     = "gamedb"
db_username = "admin"

# Auto Scaling Group Configuration
desired_capacity = 2
max_size         = 4
min_size         = 1
