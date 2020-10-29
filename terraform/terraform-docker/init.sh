#!/bin/bash

echo "baixando terraform"
wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip
unzip terraform_0.13.0_linux_amd64.zip
mv terraform /bin/
terraform

echo "terraform instalado"

echo "baixando plugins necessários"
terraform init

terraform plan 

echo "terraform apply automático"
terraform apply -auto-approve 
