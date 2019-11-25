resource "aws_security_group" "control_server_sg" {
  name        = "Control Server Security Group"
  description = "Security group for the Control Server"
  vpc_id      = "vpc-27c7b15d"

  ingress {
    from_port   = 22
    to_port     = 22 
    protocol    = "tcp"
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
  ami             = "ami-02eac2c0129f6376b"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.control_server_sg.id]
  subnet_id       = "subnet-57052579"
  key_name        = "private"

  tags =  {
    Name = "control_server"
    Group = "control_servers"
  }

  connection {
    user = "centos"
    host = aws_instance.control_server.public_ip
    private_key = file("/home/cobioma/Backend_Software_Dev/private.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname control_server",
    ]
  }

}
