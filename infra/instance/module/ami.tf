# Get latest public ubuntu AMI ID from Parameter Store in chosen region
data "aws_ami" "ubuntu" {
  
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}

data "aws_ami" "amazon_linux" {

  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220316.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989", "785737495101"]

}

data "aws_ami" "redhat" {

  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.5.0_HVM-20211103-x86_64-0-Hourly2-GP2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["309956199498"]

}
