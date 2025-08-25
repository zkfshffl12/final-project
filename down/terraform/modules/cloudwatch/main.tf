# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "application" {
  name_prefix       = "/aws/application/${var.environment}-"
  retention_in_days = 30

  tags = {
    Name        = "${var.environment}-application-logs"
    Environment = var.environment
  }
}

# ECS용 CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "${var.environment}-ecs-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ECS CPU utilization"
  alarm_actions       = []

  tags = {
    Name        = "${var.environment}-ecs-cpu-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "${var.environment}-ecs-memory-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ECS memory utilization"
  alarm_actions       = []

  tags = {
    Name        = "${var.environment}-ecs-memory-alarm"
    Environment = var.environment
  }
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization"],
            ["AWS/ECS", "MemoryUtilization"]
          ]
          period = 300
          stat   = "Average"
          region = "ap-northeast-2"
          title  = "ECS Metrics"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_name],
            [".", "TargetResponseTime", ".", "."]
          ]
          period = 300
          stat   = "Sum"
          region = "ap-northeast-2"
          title  = "ALB Metrics"
        }
      }
    ]
  })
}
