output "private_ip" {
  value = aws_instance.instances.*.private_ip
}

output "public_ip" {
  value = aws_instance.instances.*.public_ip
}

output "instance_id" {
  value = aws_instance.instances.*.id
}

output "network_interface_id" {
  value = aws_instance.instances.*.primary_network_interface_id
}

output "security_group" {
  value = aws_security_group.this
}
