locals {

  ami_os_id = {
    amazon_linux = data.aws_ami.amazon_linux.id
    redhat       = data.aws_ami.redhat.id
    ubuntu       = data.aws_ami.ubuntu.id
  }

}

resource "aws_instance" "instances" {

  depends_on = [
    data.aws_ami.ubuntu,
    data.aws_ami.amazon_linux,
    data.aws_ami.redhat
  ]

  count = var.count_instances != 0 ? var.count_instances : 0

  ami                         = var.ami_id == "" ? lookup(local.ami_os_id, var.ami_os) : var.ami_id
  instance_type               = var.machine_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.this.id]
  private_ip                  = length(var.private_ip) > 1 ? var.private_ip[count.index] : var.private_ip[0]
  associate_public_ip_address = var.public_ip
  user_data                   = file(var.script_location)

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  tags = {
    Name        = var.count_instances > 1 ? "${var.instance_name}-${count.index}" : var.instance_name,
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
      vpc_security_group_ids
    ]
  }

}

resource "aws_eip" "static_ip" {

  count    = var.elastic_ip && var.count_instances == 1 ? var.count_instances : 0

  instance = aws_instance.instances[0].id
  vpc      = true

  tags = {
    Name        = "eip-${var.instance_name}",
    Environment = var.environment
  }

}
