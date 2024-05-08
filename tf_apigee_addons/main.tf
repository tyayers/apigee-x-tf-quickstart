variable "project_id" {
  description = "Project id (also used for the Apigee Organization)."
  type        = string
}

module "apigee" {
  source     = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/apigee"
  project_id = var.project_id
  addons_config = {
    monetization = true
    api_security = true
    advanced_api_ops = true
  }
}