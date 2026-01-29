resource "aws_secretsmanager_secret" "devops_secret" {
  name = "devops-secret"
}

resource "aws_secretsmanager_secret_version" "devops_secret_value" {
  secret_id = aws_secretsmanager_secret.devops_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
  })
}