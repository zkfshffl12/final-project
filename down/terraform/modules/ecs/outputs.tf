output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.main.id
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.main.arn
}

output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "service_id" {
  description = "ECS service ID"
  value       = aws_ecs_service.backend.id
}

output "service_arn" {
  description = "ECS service ARN"
  value       = aws_ecs_service.backend.arn
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.backend.name
}

output "task_definition_arn" {
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.backend.arn
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = aws_security_group.ecs.id
}

output "execution_role_arn" {
  description = "ECS execution role ARN"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "task_role_arn" {
  description = "ECS task role ARN"
  value       = aws_iam_role.ecs_task_role.arn
}
