# infracost-budgets
Create an AWS budget from infracost workload estimates

This assumes you already have [infracost](https://github.com/infracost/infracost) / [terragrunt](https://github.com/gruntwork-io/terragrunt) & [terraform](https://www.terraform.io) installed & understand them. It leans on terragrunt dependencies to generate what's required dynamically to then generate the inputs to the AWS budget(s). This is very much a MVP to show how you can generate budgets from infracost estimates dynamically.

