provider "aws" {

  region                  = local.aws_region
  shared_credentials_file = local.aws_credential_file
  profile                 = local.aws_credential_profile
  skip_region_validation  = local.aws_skip_region_validation

}

terraform {

  required_version = ">= 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.4"
    }
  }

}

data "terraform_remote_state" "network" {

  backend = "local"

  config = {
    path = "../network/terraform.tfstate"
  }

}

data "aws_availability_zones" "available" {}

module "instance" {

  source = "./module"

  vpc_id          = data.terraform_remote_state.network.outputs.network.vpc_id
  ami_id          = local.ami_id != "" ? local.ami_id : ""
  ami_os          = local.ami_os != "" ? local.ami_os : ""
  count_instances = local.count_instances
  instance_name   = local.instance_name
  environment     = local.environment
  machine_type    = local.machine_type
  subnet_id       = data.terraform_remote_state.network.outputs.network.public_subnets[0]
  elastic_ip      = local.elastic_ip
  public_ip       = local.subnet_type == "public" ? true : false
  private_ip      = local.private_ip
  sg_name         = local.sg_name
  create_key      = local.create_key
  key_name        = local.key_name
  public_key      = file("public.key")
  script_location = "../../scripts/${local.script_name}"
  volume_type     = local.volume_type
  volume_size     = local.volume_size

}

resource "null_resource" "check-connection" {

  depends_on = [
    module.instance
  ]

  provisioner "local-exec" {
    command     = <<-EOF
      while [[ -z $(aws ec2 describe-instance-status --instance-ids ${module.instance.instance_id[0]} | grep passed) ]]; do 
        echo "wait instance ready ..."; 
        sleep 10; 
      done
EOF
    interpreter = ["bash", "-c"]
  }

}

resource "null_resource" "export-compose" {

  depends_on = [
    null_resource.check-connection
  ]

  provisioner "file" {

    source      = "../../compose"
    destination = "./"

    connection {
      type        = "ssh"
      host        = module.instance.public_ip[0]
      user        = "${local.user_ssh}"
      private_key = file("~/.ssh/id_rsa")
    }

  }

  provisioner "file" {

    source      = "../../scripts"
    destination = "./"

    connection {
      type        = "ssh"
      host        = module.instance.public_ip[0]
      user        = "${local.user_ssh}"
      private_key = file("~/.ssh/id_rsa")
    }
  }

}

resource "null_resource" "docker-compose-up" {

  depends_on = [
    null_resource.export-compose
  ]

  connection {
    type        = "ssh"
    host        = module.instance.public_ip[0]
    user        = "${local.user_ssh}"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x -R scripts",
      "cd scripts",
      "bash provision-elk.sh"
    ]
  }

}

output "instances_private_ip" {
  value = module.instance.private_ip
}

output "instances_public_ip" {
  value = module.instance.public_ip
}

output "instnace_id" {
  value = module.instance.instance_id
}
