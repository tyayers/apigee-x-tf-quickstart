/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

region = "europe-west4"

network="default"

apigee_instances = {
  instance-1 = {
    region       = "europe-west4"
    ip_range     = "10.0.0.0/22"
    environments = ["dev", "prod"]
  }
}

psc_ingress_subnets = [
  {
    name               = "apigee-psc-in1"
    ip_cidr_range      = "10.100.0.0/24"
    region             = "europe-west4"
    secondary_ip_range = null
  }
]

# Environment type can be BASE, INTERMEDIATE, or COMPREHENSIVE
apigee_environments = {
  dev = {
    display_name = "dev"
    description  = "Apigee environment for development."
    node_config  = null
    iam          = null
    envgroups    = ["dev"]
    type         = "INTERMEDIATE"
  }
}

apigee_envgroups = {
  dev = {
    hostnames = []
  }
}

# Can be either PAYG, EVALUATION, or SUBSCRIPTION
apigee_billing_type = "PAYG"

psc_ingress_network = "psc-ingress"

peering_range = "10.0.0.0/20"
support_range = "10.1.0.0/28"