#!/bin/bash

DEPLOY_ENV=${1:-dev}

# validation hack
echo -e "dev\ntest\nprod" | grep $DEPLOY_ENV 1>/dev/null
if [[ $? -ne 0 ]]
then
    echo "bad env arg passed: $DEPLOY_ENV ... exiting"
else 
    echo "destroying in $DEPLOY_ENV ..."
fi

cd terraform

# Execute Terraform
terraform init
terraform destroy -auto-approve -var-file="$DEPLOY_ENV.tfvars"

cd ..

echo "finished destroying in $DEPLOY_ENV"
