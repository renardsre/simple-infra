resource "aws_security_group" "this" {

  name        = "${var.sg_name}-sg"
  description = "This is security group for ${var.instance_name} instance"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }

  lifecycle {
    ignore_changes = [
      name,
      description
    ]
  }

}
