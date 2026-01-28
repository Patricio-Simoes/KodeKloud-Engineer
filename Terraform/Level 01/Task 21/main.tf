resource "aws_cloudwatch_log_group" "log_group" {
  name = "nautilus-log-group"
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "nautilus-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}