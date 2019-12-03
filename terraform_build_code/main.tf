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

# resource "aws_dynamodb_table_item" "MovieCollection" {
#   table_name = aws_dynamodb_table.MovieCollection.name
#   hash_key   = aws_dynamodb_table.MovieCollection.hash_key
#   item = <<ITEM
# {
#   "MovieId": {"S": "1"},
#   "Title": {"S": "Terminator"},
#   "Format": {"S": "DVD"},
#   "Length": {"S": "33333"},
#   "ReleaseYear": {"S": "1984"},
#   "Ratings": {"S": "5"}
# }
# ITEM
# }

# resource "aws_dynamodb_table" "MovieCollection" {
#   name           = "MovieCollection-name"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "MovieId"
#   range_key      = "Title"

#   attribute {
#     name = "MovieId"
#     type = "S"
#   }

#   attribute {
#     name = "Title"
#     type = "S"
#   }

#   attribute {
#     name = "Format"
#     type = "S"
#   }

#   attribute {
#     name = "Length"
#     type = "S"
#   }

#   attribute {
#     name = "ReleaseYear"
#     type = "S"
#   }

#   attribute {
#     name = "Rating"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "MovieTitleIndex"
#     hash_key           = "Title"
#     range_key          = "ReleaseYear"
#     projection_type    = "ALL"
#   }

#   global_secondary_index {
#     name               = "MovieFormatIndex"
#     hash_key           = "Format"
#     range_key          = "Length"
#     projection_type    = "ALL"
#   }

#   global_secondary_index {
#     name               = "MovieRatingIndex"
#     hash_key           = "Rating"
#     range_key          = "ReleaseYear"
#     projection_type    = "ALL"
#   }


#   tags = {
#     Name        = "dynamodb-table-1"
#     Environment = "production"
#   }
# }

resource "aws_dynamodb_table_item" "MovieCollection" {
  table_name = aws_dynamodb_table.MovieCollection.name
  hash_key   = aws_dynamodb_table.MovieCollection.hash_key

  item = <<ITEM
{
  "MovieId": {"N": "1"},
  "Title": {"S": "Terminator"},
  "Format": {"S": "DVD"},
  "Length": {"S": "01:48:02"},
  "ReleaseYear": {"S": "1984"},
  "Ratings": {"S": "5"}
}
ITEM
}

resource "aws_dynamodb_table" "MovieCollection" {
  name           = "MovieCollection"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "MovieId"

  attribute {
    name = "MovieId"
    type = "N"
  }
}