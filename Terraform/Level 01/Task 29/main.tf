resource "null_resource" "aws_cli" {
  provisioner "local-exec" {
    command = "aws s3 cp s3://xfusion-bck-28485 /opt/s3-backup/ --recursive && aws s3 rm s3://xfusion-bck-28485 --recursive && aws s3api delete-bucket --bucket xfusion-bck-28485"
  }
}