locals {

  ami_id                     = ""
  ami_os                     = "amazon_linux"
  aws_credential_file        = "~/.aws/credentials"
  aws_credential_profile     = "default"
  aws_region                 = "ap-southeast-1"
  aws_skip_region_validation = true
  count_instances            = 1
  create_key                 = true
  elastic_ip                 = false
  environment                = "monitoring"
  instance_name              = "elastic-logstash-kibana"
  key_name                   = "elk-key"
  machine_type               = "t3.medium"
  private_ip                 = ["10.0.0.5"]
  user_ssh                   = "ec2-user"
  script_name                = "install-docker.sh"
  sg_name                    = "elk-sg"
  subnet_type                = "public"
  volume_type                = "gp2"
  volume_size                = 10

}
