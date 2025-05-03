terraform {
  backend "s3" {
    bucket         = "my-terraform-state-s3bucket"
    key            = "ecommerce-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}