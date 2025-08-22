output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.spring_boot.id
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.spring_boot.private_ip
}

output "key_pair_name" {
  description = "Name of the key pair"
  value       = data.aws_key_pair.existing.key_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.main.id
}
