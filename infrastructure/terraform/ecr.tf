resource "aws_ecr_repository" "frontend_repo" {
  name = "ecommerce-frontend-repo"
}

resource "aws_ecr_repository" "backend_repo" {
  name = "ecommerce-backend-repo"
}
