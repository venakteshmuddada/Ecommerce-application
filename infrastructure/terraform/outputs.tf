output "alb_dns" {
  value = aws_lb.ecs_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.ecommerce_db.endpoint
}

output "cognito_pool_id" {
  value = aws_cognito_user_pool.main.id
}
