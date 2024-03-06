# resource "aws_key_pair" "ec2_key" {
#   key_name   = "${var.environment}-${var.key_name}"
#   public_key = tls_private_key.ziyo_key.public_key_openssh
# }

# resource "tls_private_key" "ziyo_key" {
#   algorithm   = "RSA"
#   ecdsa_curve = "P384" 
# }

# resource "local_file" "ziyo_send" {
#     content     = tls_private_key.ziyo_key.private_key_pem
#     filename = "../../../Keys/devops-class-key.pem"
# }
