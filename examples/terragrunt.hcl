terraform {
  // we just need to run infracost in a before hook, infracost needs to be available on the PATH.
  before_hook "run-infracost" {
    commands = ["plan", "apply"]
    execute = ["infracost", "breakdown", "--path", "${get_terragrunt_dir()}", "--format", "json", "--out-file", "${local.estimate_file}"]
  }
}

locals {
  // creates an estimate file, named directroy-name.json
  estimate_file = "${get_terragrunt_dir()}/${basename(abspath(get_terragrunt_dir()))}.json"
  // name of the budget taken from directory name
  budget_name = basename(abspath(get_terragrunt_dir()))
}

// Generates terraform provider
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
}

// Generates a small TF file with the budget module decalared
generate "budget_module" {
    path      = "module.tf"
    if_exists = "overwrite"
    contents = <<EOF
module "budget" {
  source = "${get_repo_root()}"
  budget_name = "${local.budget_name}"
  budget_estimate_file = "${local.estimate_file}"
}
EOF
}