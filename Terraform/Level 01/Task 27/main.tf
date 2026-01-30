# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_ammar"

  tags = {
    Name = "iamuser_ammar"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_ammar"
  description = "IAM policy allowing EC2 read actions for ammar"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "ammar" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}