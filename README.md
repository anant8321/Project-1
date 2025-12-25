# aws-webapp-terraform

## Folder Structure
```text
aws-webapp-terraform/
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── compute/
│   │   ├── main.tf        # LT + ASG
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data.sh
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── monitoring/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── provider.tf
│       ├── backend.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── outputs.tf
│
├── diagrams/
│   └── architecture.png
│
├── README.md
└── .gitignore
