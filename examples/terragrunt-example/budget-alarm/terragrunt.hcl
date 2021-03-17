terraform {
  source = "../../../"
}

inputs = {
  budget_list = local.module_list
  notification_subscriber_value = ["some_email_address"]
}

locals {
  // Set the name of this module folder
  module_dir = basename(get_terragrunt_dir())
  // Find all directories containing
  find_dirs = fileset("../", "**/*.hcl")
  // Create a list of modules that we need to pass into the budget Alarm module to generate budget alarms for each module
  module_list = distinct([for dir in local.find_dirs: split("/.", dirname(dir))[0] if split("/.", dirname(dir))[0] != local.module_dir])
}

// Iterate the module_list to generate dependency paths
dependencies {
  paths = [for dir in local.module_list: "..//${dir}"]
}
