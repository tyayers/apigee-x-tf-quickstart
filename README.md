# Apigee X Terraform Quickstart
This is a simple template for creating Google Cloud Apigee X projects with useful settings using Terraform. This builds upon amazing modules in the repositories [apigee/terraform-modules](https://github.com/apigee/terraform-modules) and [GoogleCloudPlatform/cloud-foundation-fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric).

## Resources created
Here are the resources created by this quickstart.

- A Google Cloud project
  - Some org policies are configured to fit publicly accessable APIs in Apigee X:
    - The policies **compute.requireOsLogin** and **compute.requireShieldedVm** are both set to **false**.
    - The policies **iam.allowedPolicyMemberDomains** and **compute.vmExternalIpAccess** are set to **allow all=true**.
- A free Apigee X evaluation instance is provisioned in a given Google Cloud region (default europe-west1 Belgium) with two environments, **dev** and **prod**.
- The **dev** and **prod** environment groups, a public load balancer, and certificates with **nip.io** are also provisioned.
- A **PSC (Private Service Connect)** attachment is also used to connect the public load balancer to the Apigee X instance.
- If the directory `tf_apigee_integration` is used, then Application Integration is also provisioned in the chosen region.

## Deployment
You can deploy this manually running these shell commands in your environment of choice (**gcloud** and **terraform** have to be installed).

```sh
# Clone the repository and switch to the directory
git clone https://github.com/tyayers/apigee-x-tf-quickstart.git; cd apigee-x-tf-quickstart

# Copy the environment variables file and edit with your values
cp 1_env.sh 1_env.local.sh
nano 1_env.local.sh
source 1_env.local.sh

# Change to the tf_apigee_simple or tf_apigee_integration directory
cd tf_apigee_simple

# Run terraform init on the configuration
terraform init

# Apply the terraform configuration for Apigee eval, creating a project and Apigee X instance and two environments (dev and prod)
terraform apply -var "project_id=$PROJECT_ID" -var "billing_id=$BILLING_ID" -var "project_create=false" --var-file=./x-apigee.tfvars

# Destroy project when finished
terraform destroy --var-file=./x-apigee.tfvars
```