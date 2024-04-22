# Apigee X Terraform Quickstart Demo

---

This tutorial shows you how to configure and provision a completely automated GCP project, Apigee X org and instance, and a sample proxy.

Let's get started!

---

## Setup environment

First, copy the provided sample `x-eval.tfvars` file, and set the variables there for your deployment.

```sh
cd tf
cp x-eval.tfvars x-eval.dev.tfvars
```
Click to copy into a new variables file.

After copying the file, click <walkthrough-editor-open-file filePath="./tf/x-eval.dev.tfvars">here</walkthrough-editor-open-file> to open the file in the editor. Set the the first three variables to your own values.

---

## Init Terraform

Click <walkthrough-editor-open-file filePath="./tf/main.tf">here</walkthrough-editor-open-file> to view the base terraform configuration, including the GCP project configuration, org policies, and networking config.

Now let's init our configuration:

```sh
terraform init
```
Click the arrow above to copy this into your shell and press enter to run the command.

This will set the correct org policies that Apigee needs for a typical demo or test environment.

<walkthrough-footnote>This is just an example configuration, you can customize the policies and provisioning as needed for your needs.</walkthrough-footnote>

---

## Apply Terraform configuration

Now we are ready to apply the configuration, which will create our GCP project, the Apigee X instance and environments, and a load balancer and certificate to reach our API endpoints.

```sh
terraform apply --var-file=./x-eval.dev.tfvars
```
Click the arrow above to copy this command into your shell and then press enter to run the command. It can take 20-30 minutes to provision the environment.

---

## Deploy an Apigee proxy directly from an OpenAPI spec

Now that we have our Apigee org and environment, we can  deploy an API proxy using an API spec. The easiest way to do this is using the tool [apigeecli](https://github.com/apigee/apigeecli). Let's first install the tool in our shell by running this command.

```sh
curl -L https://raw.githubusercontent.com/apigee/apigeecli/master/downloadLatest.sh | sh -
export PATH=$PATH:$HOME/.apigeecli/bin
```

Now we can create an API proxy based on a local OpenAPI specification from our repository. Click <walkthrough-editor-open-file filePath="./specs/user-api.yaml">here</walkthrough-editor-open-file> to open the the file in the editor.

To deploy the API proxy, we're going to need your new Google Cloud project Id, so set that as an environment variable in our shell now.

```sh
# Set the variable to the same project Id you used in x-eval.dev.tfvars
PROJECT_ID=YOUR_PROJECT_ID
```

Now let's import the spec file as an API in our Apigee X environment.

```sh
# Set the project as the current project in gcloud
gcloud config set project $PROJECT_ID

# Then get a token to use for the command
TOKEN=$(gcloud auth print-access-token)

# Now use apigeecli to create an API proxy from the spec and deploy it to our new Apigee dev environment
apigeecli apis create openapi -t $TOKEN -o $PROJECT_ID -e dev --ovr -n UserAPI-v1 -p /hello --oas-base-folderpath ./specs --oas-name user-api.yaml
```

Now check out the deployed proxy in the [Apigee console](https://console.cloud.google.com/apigee/overview). To test the API, go to the **API Proxies** menu on the left-hand side, click on the entry for **UserAPI-v1**, and after the deployment is complete click on **DEBUG** to start a debug session. After the dubug session is running, open the **URL** in the session information to call the API a few times. You should see the API calls in the **Debug** session. 

---

## Conclusion
<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You've successfully provisioned Apigee X with Terraform, and deployed a first proxy using apigeeli. You are now an **honorary Apigeek!**

<walkthrough-inline-feedback></walkthrough-inline-feedback>