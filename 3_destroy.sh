cd tf

terraform destroy -var "project_id=$PROJECT_ID" -var "billing_account=$BILLING_ID" -var "region=$REGION" -var "add_user=$GCP_ADD_USER" -var "project_create=true"

cd ..