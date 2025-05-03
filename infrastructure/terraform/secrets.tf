resource "aws_secretsmanager_secret" "db_secret" {
  name = "ecommerce-db-credentials-2"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "YourSecurePassword123"
  })
}
