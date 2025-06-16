#!/bin/bash

PROJECT_NAME="aca-finops-demo"
LOCATION="westeurope"
USE_MANAGED_PG=true

echo "🔐 Iniciando sesión en Azure..."
az login

read -p "¿Establecer suscripción? (ENTER para omitir): " SUB_ID
if [ ! -z "$SUB_ID" ]; then
  az account set --subscription "$SUB_ID"
fi

terraform init
terraform apply -auto-approve \
  -var="project_name=$PROJECT_NAME" \
  -var="location=$LOCATION" \
  -var="use_managed_postgres=$USE_MANAGED_PG"
