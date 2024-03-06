data "aws_ami" "example" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20211001.1-x86_64-gp2"]
  }
}