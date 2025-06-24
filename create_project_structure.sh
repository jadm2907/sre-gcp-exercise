#!/bin/bash

# Create directories and files
mkdir -p packer/
touch packer/bastion.json

mkdir -p ansible/
touch ansible/playbook.yml
touch ansible/inventory.yml

mkdir -p terraform/modules/{load_balancer,cloud_dns,bastion,gke,container_registry,cloud_sql}
touch terraform/main.tf
touch terraform/variables.tf
touch terraform/outputs.tf

# Create Terraform module files
for module in cloud_dns bastion gke container_registry cloud_sql; do
    touch terraform/modules/$module/main.tf
    touch terraform/modules/$module/variables.tf
    touch terraform/modules/$module/outputs.tf
done

mkdir -p app/
touch app/main.py
touch app/requirements.txt
touch app/Dockerfile

touch README.md

mkdir -p docs/
touch docs/configuracion.md

# Add basic content to key files
cat > ansible/inventory.yml <<EOL
all:
  hosts:
    localhost:
      ansible_connection: local
EOL

cat > ansible/playbook.yml <<EOL
---
- name: Sample playbook
  hosts: all
  tasks:
    - name: Sample task
      debug:
        msg: "Hello world!"
EOL

cat > terraform/main.tf <<EOL
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  # Configuration options
}
EOL

cat > terraform/variables.tf <<EOL
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
EOL

cat > app/Dockerfile <<EOL
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "main.py"]
EOL

echo "Project structure created successfully!"