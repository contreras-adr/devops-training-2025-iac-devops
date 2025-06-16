#!/bin/bash

# Variables
USER_NAME="terraform-deployer"
GROUP_NAME="training-devops-2025"
POLICY_NAME="TerraformDeployPolicy"
PROFILE="devops-training-2025"
REGION="eu-west-1"

# 1. Crear el grupo si no existe
aws iam get-group --group-name $GROUP_NAME --profile $PROFILE 2>/dev/null
if [ $? -ne 0 ]; then
  echo "Creando grupo: $GROUP_NAME"
  aws iam create-group --group-name $GROUP_NAME --profile $PROFILE
fi

# 2. Crear política inline mínima
cat > policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "ecs:*",
        "ecr:*",
        "iam:PassRole",
        "logs:*"

      ],
      "Resource": "*"
    }
  ]
}
EOF

# 3. Adjuntar política inline al grupo
aws iam put-group-policy \
  --group-name $GROUP_NAME \
  --policy-name $POLICY_NAME \
  --policy-document file://policy.json \
  

# 4. Crear el usuario IAM
aws iam create-user --user-name $USER_NAME 

# 5. Añadir usuario al grupo
aws iam add-user-to-group --user-name $USER_NAME --group-name $GROUP_NAME 

# 6. Crear claves de acceso
aws iam create-access-key --user-name $USER_NAME  > credentials.json

echo "✅ Usuario '$USER_NAME' creado y añadido al grupo '$GROUP_NAME'"
echo "📁 Claves de acceso almacenadas en 'credentials.json'"
