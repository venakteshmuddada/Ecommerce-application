Phase 1: Prerequisites & Setup
✅ Local Setup
Install: Terraform, Git, Node.js, Docker (for local testing)

GitHub:

Repo: https://github.com/venakteshmuddada/Ecommerce-application.git

Add folders: frontend/, backend/, infrastructure/terraform/, buildspec.yml, scripts/deploy.sh, README.md

🌐 Phase 2: Infrastructure Setup using Terraform
✅ Module 1: VPC and Networking (Skip if using existing VPC/Subnets)
Since you've shared:

**VPC: vpc-045409f9dc02cd4e1

Subnets: subnet-0a37cf861b1a56e2b, subnet-0303a79a44a64c950**
![VPC](https://github.com/user-attachments/assets/38c15018-0b3d-444f-84fa-fd7a2075176d)

We'll reference these in modules instead of creating new ones.

✅ Module 2: IAM Roles
Create roles for:
![Terraform execution0305](https://github.com/user-attachments/assets/d8b8f2aa-3912-43f6-9abe-d0371c8f2782)


ECS Task Execution

CodeBuild

CodePipeline

CodeDeploy

RDS access (through Secrets Manager)

✅ Module 3: S3
Store:

Static frontend assets

Build artifacts
![bucket](https://github.com/user-attachments/assets/2a504be8-7467-4434-bee6-a4ed6aee57d4)


✅ Module 4: RDS MySQL
Private DB with:

username & password stored in AWS Secrets Manager

Subnet group from provided subnets

✅ Module 5: ECS with Fargate
Deploy frontend and backend as separate services

Use ALB for routing

Dockerize both applications

✅ Module 6: Cognito
For authentication (User Pool, App Client, Domain) -** Not configured**

⚙️ Phase 3: Application Development & Dockerization
✅ Folder Structure

ecommerce-app/
├── frontend/ (React)
├── backend/ (Node.js + Express + MySQL config)
├── Dockerfile (for both apps)
├── buildspec.yml (frontend & backend)
├── scripts/deploy.sh
└── infrastructure/terraform/
✅ Add Dockerfiles
Build React app

Serve via Nginx

Backend app with MySQL integration
![RDS](https://github.com/user-attachments/assets/99f5e49a-ba91-4d6b-8829-700b1756e3df)


🚀 Phase 4: CI/CD Pipeline
✅ Pipeline Flow

GitHub Push → CodePipeline → CodeBuild (frontend/backend) → ECS deploy via CodeDeploy
✅ Terraform Resources
aws_codepipeline

aws_codebuild_project

aws_codedeploy_app + deployment_group
![pipeline sucessful](https://github.com/user-attachments/assets/ada61f7f-5ebb-4211-a011-fe3b48d00ad5)

✅ Scripts
buildspec.yml: For CodeBuild

deploy.sh: Push images to ECR & update ECS service

📊 Phase 5: Observability & Alerts
✅ CloudWatch Alarms:
ECS Service metrics (CPU, memory)

RDS metrics

✅ Logging:
Enable CloudWatch logs in ECS task definitions
![Cloudwatch](https://github.com/user-attachments/assets/e8b3d8f5-9672-4f56-82ce-b4c2b1431e8d)

📁 Terraform modules attached:

vpc.tf, iam.tf, ecs.tf, rds.tf, s3.tf, cognito.tf, pipeline.tf

buildspec.yml files (frontend & backend)

Dockerfiles (for frontend and backend)

Application boilerplate (basic React frontend & Node.js backend)

GitHub project push structure


**GitHub Push → CodePipeline → CodeBuild (frontend/backend) → ECS deploy via CodeDeploy**

![Ecommerse web](https://github.com/user-attachments/assets/2ad6b050-1289-49a0-8261-f4564543e77e)
![ec2backendurl](https://github.com/user-attachments/assets/f5809e48-13a7-4450-9046-f9402acc659f)

