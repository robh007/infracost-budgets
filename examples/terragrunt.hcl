terraform {
  // we just need the Terraform code to run infracost.
  before_hook "run-infracost" {
    commands = ["plan", "apply"]
    execute = ["bash", "./infracost.sh"]
  }
}

// set the file name for each module.
locals {
  module_name = basename(abspath(get_terragrunt_dir()))
  budget_directory = "${get_terragrunt_dir()}/../budget-alarm/${local.module_name}.json"
}

generate "infracost" {
  path = "infracost.sh"
  if_exists = "overwrite"
  contents = <<EOF
#!/bin/bash
infracost --terraform-dir . --format json > ${local.budget_directory}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
}
