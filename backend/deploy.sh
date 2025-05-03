#!/bin/bash

# Variables
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-east-1"

# Authenticate Docker
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# Build and push frontend
cd ../frontend
docker build -t ecommerce-frontend .
docker tag ecommerce-frontend:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ecommerce-frontend-repo:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ecommerce-frontend-repo:latest

# Build and push backend
cd ../backend
docker build -t ecommerce-backend .
docker tag ecommerce-backend:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ecommerce-backend-repo:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/ecommerce-backend-repo:latest
