cd tf

terraform init
terraform apply --var-file=./x-eval.dev.tfvars

cd ..