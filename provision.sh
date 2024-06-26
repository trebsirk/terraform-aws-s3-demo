#!/bin/bash

DEPLOY_ENV=${1:-dev}

# validation hack
echo -e "dev\ntest\nprod" | grep $DEPLOY_ENV 1>/dev/null
if [[ $? -ne 0 ]]
then
    echo "bad env arg passed: $DEPLOY_ENV ... exiting"
else 
    echo "provisioning to $DEPLOY_ENV ..."
fi

cd terraform

echo "terraform init ..."
terraform init
echo "terraform fmt ..."
terraform fmt -check
echo "terraform plan ..."
terraform plan -input=false -var-file="$DEPLOY_ENV.tfvars"
echo "terraform apply ..."
terraform apply -auto-approve -input=false -var-file="$DEPLOY_ENV.tfvars"

cd ..

echo "finished provisioning to $DEPLOY_ENV"
