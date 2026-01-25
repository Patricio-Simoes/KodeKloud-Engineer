resource "aws_instance" "devops_machine" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  tags = {
    Name = "devops_machine"
  }
}

resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name          = "devops-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300 # 5 minutes in seconds.
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers when the DevOps EC2 CPU usage exceeds 80%"

  dimensions = {
    InstanceId = aws_instance.devops_machine.id
  }
}