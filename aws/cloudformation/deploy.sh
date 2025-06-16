#!/bin/bash

STACK_NAME=$1
TEMPLATE_FILE=$2
PROFILE=$3
REGION="eu-west-1"

echo "📦 Desplegando stack: $1 ($2)"
echo "🔐 Usando perfil: $3"


aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile $PROFILE \
  --region $REGION

echo "✅ Stack desplegado. Outputs:"
aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --profile $PROFILE \
  --region $REGION \
  --query "Stacks[0].Outputs"