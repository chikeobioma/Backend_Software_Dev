resource "aws_security_group" "control_server_sg" {
  name        = "Control Server Security Group"
  description = "Security group for the Control Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "control_server" {
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.control_server_sg.id]
  subnet_id       = var.subnet_id
  key_name        = var.key_name

  tags =  {
    Name = "control_server"
    Group = "control_servers"
  }

  connection {
    user = var.users[0]
    host = aws_instance.control_server.public_ip
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname control_server",
    ]
  }

}
