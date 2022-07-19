data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group_rule" "ingress_rule_ssh" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"]
  description       = "open port 22 for internal server"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_http" {

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port http for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_https" {

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port http for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_logstash_tcp_5000" {

  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port logstash for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_logstash_udp_5000" {

  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port logstash for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_logstash_udp_5044" {

  type              = "ingress"
  from_port         = 5044
  to_port           = 5044
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port logstash for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_logstash_tcp_5959" {

  type              = "ingress"
  from_port         = 5959
  to_port           = 5959
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port logstash for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_logstash_udp_5959" {

  type              = "ingress"
  from_port         = 5959
  to_port           = 5959
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port logstash for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_kibana" {

  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port kibana for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_apm" {

  type              = "ingress"
  from_port         = 8200
  to_port           = 8200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port apm for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_sonarqube" {

  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port sonarqube for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_elasticsearch" {

  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port elasticsearch for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_9600" {

  type              = "ingress"
  from_port         = 9600
  to_port           = 9600
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  description       = "open port 9600 for public access"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_icmp" {

  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["16.0.0.0/16", "10.0.0.0/16", "172.0.0.0/16"]
  description       = "open port ICMP for internal server"
  security_group_id = module.instance.security_group.id

}

resource "aws_security_group_rule" "ingress_rule_all_traffic" {

  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "open port all traffic access"
  security_group_id = module.instance.security_group.id

}
