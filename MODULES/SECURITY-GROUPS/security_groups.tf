resource "aws_security_group" "ziyotek_devops_all_all" {
  name        = "${var.environment}-${var.sg_name}"
  description = "${var.sg_description}-in-${var.environment}"
  vpc_id      = var.sg_vpc #aws_vpc.ziyotek_devops.id

  ingress {
    description = "TLS from VPC-${var.environment}"
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks # ["0.0.0.0/16, 10.10.0.0/24"]
  }

  egress {
    from_port        = var.sg_egress_from_port
    to_port          = var.sg_egress_to_port
    protocol         = var.sg_egress_protocol
    cidr_blocks      = var.sg_egress_cidr_blocks
    ipv6_cidr_blocks = var.sg_egress_ipv6_cidr_blocks
  }
}