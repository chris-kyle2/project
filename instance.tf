resource "aws_instance" "app_instance" {
  count                       = var.instance_count
  ami                         = var.AMIS
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.MyServer1.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  security_groups             = [aws_security_group.app_sg.id]
  associate_public_ip_address = true
  connection {
    type        = "ssh"
    user        = var.username
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  tags = {
    Name = "AppInstance"
  }
}
