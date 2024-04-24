cd tf_apigee_simple

terraform init
terraform apply --var-file=./x-eval.dev.tfvars

cd ..