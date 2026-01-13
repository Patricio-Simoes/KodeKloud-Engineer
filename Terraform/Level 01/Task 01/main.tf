# Generate the RSA private key locally.
resource "tls_private_key" "xfusion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the AWS key pair using the public key from the TLS resource.
resource "aws_key_pair" "xfusion_kp" {
  key_name   = "xfusion-kp"
  public_key = tls_private_key.xfusion_key.public_key_openssh
}

# Save the generated private key locally.
resource "local_file" "private_key_pem" {
  content         = tls_private_key.xfusion_key.private_key_pem
  filename        = "/home/bob/xfusion-kp.pem"
  file_permission = "0400"
}