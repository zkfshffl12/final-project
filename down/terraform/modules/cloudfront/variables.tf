variable "environment" {
  description = "Environment name"
  type        = string
}

variable "alb_domain_name" {
  description = "ALB domain name for API origin"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "S3 bucket regional domain name for static files"
  type        = string
}
