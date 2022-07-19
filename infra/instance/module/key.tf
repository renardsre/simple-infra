resource "aws_key_pair" "key_instance" {

  count      = var.create_key ? 1 : 0

  key_name   = var.key_name
  public_key = var.public_key

}
