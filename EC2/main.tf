resource "aws_instance" "dev" {
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
      Name = "Anar-Web-Server"
  }
}

resource "aws_vpc" "ec2_vpc" {
  cidr_block = "30.10.0.0/16"
  
}