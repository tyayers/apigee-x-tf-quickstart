# Apigee X Terraform Quickstart
This is a simple template for creating Google Cloud Apigee X projects with useful settings using Terraform. This builds upon amazing modules in the repositories [apigee/terraform-modules](https://github.com/apigee/terraform-modules) and [GoogleCloudPlatform/cloud-foundation-fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric).

## Resources created
Here are the resources created by this quickstart.

- A Google Cloud project
  - Some org policies are configured to fit publicly accessable APIs in Apigee X:
    - The policies **compute.requireOsLogin** and **compute.requireShieldedVm** are both set to **false**.
    - The policies **iam.allowedPolicyMemberDomains** and **compute.vmExternalIpAccess** are set to **allow all=true**.
    - A configured user is added to the project with the roles **editor** and **apigee.admin**.
- A free Apigee X evaluation instance is provisioned in a given Google Cloud region (default europe-west1 Belgium) with two environments, **dev** and **prod**.
- The **dev** and **prod** environment groups, a public load balancer, and certificates with **nip.io** are also provisioned.
- A **PSC (Private Service Connect)** attachment is also used to connect the public load balancer to the Apigee X instance.

## Deployment
You can deploy this with a tutorial in **Google Cloud Shell** by clicking this button.

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.png)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/tyayers/apigee-x-tf-quickstart&cloudshell_git_branch=master&cloudshell_workspace=.&cloudshell_tutorial=docs/tutorial.md)

### Manual deployment (also easy!)
You can deploy this manually running these shell commands in your environment of choice (**gcloud** and **terraform** have to be installed).

```sh
# Clone the repository and switch to the directory
git clone https://github.com/tyayers/apigee-x-tf-quickstart.git; cd apigee-x-tf-quickstart

# Copy the env file and add your own project and billing information
cp 1_env.sh 1_env.dev.sh
# Edit the 1_env.dev.sh file with your project and billing information
source 1_env.dev.sh

# Run terraform init on the configuration
cd tf
terraform init

# Apply the terraform configuration for Apigee eval, creating a project and Apigee X instance and two environments (dev and prod)
terraform apply --var-file=./x-eval.tfvars \
-var "project_id=$PROJECT_ID" \
-var "project_create=true" \
-var "billing_account=$BILLING_ID" \
-var "apigee_admin=$APIGEE_ADMIN"

# Destroy project when finished
terraform destroy --var-file=./x-eval.tfvars \
-var "project_id=$PROJECT_ID" \
-var "project_create=true" \
-var "billing_account=$BILLING_ID" \
-var "apigee_admin=$APIGEE_ADMIN"
```