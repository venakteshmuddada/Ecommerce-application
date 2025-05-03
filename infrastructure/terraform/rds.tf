resource "aws_db_subnet_group" "default" {
  name = "rds-subnet-group"
  subnet_ids = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]
}

resource "aws_db_instance" "ecommerce_db" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "ecommercedb" # ← Fixed here
  username               = "admin"
  password               = "YourSecurePassword123"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}


resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Allow MySQL access"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
