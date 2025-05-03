resource "aws_cognito_user_pool" "main" {
  name = "ecommerce-user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name            = "ecommerce-app-client"
  user_pool_id    = aws_cognito_user_pool.main.id
  generate_secret = false

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]

  callback_urls = ["https://localhost/callback"]
  logout_urls   = ["https://localhost/logout"]

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "ecommerce-app-auth-${random_id.domain.hex}"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "random_id" "domain" {
  byte_length = 4
}
