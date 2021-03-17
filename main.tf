resource "aws_budgets_budget" "this" {
  for_each = toset(var.budget_list)
  name_prefix = each.key

  budget_type       = var.budget_type
  limit_amount      = fileexists("${each.key}.json") ? lookup(jsondecode(file("${each.key}.json")), "totalMonthlyCost") : var.budget_limit_amount
  limit_unit        = var.budget_limit_unit
  time_period_start = local.time_period_start
  time_unit         = var.time_unit

  notification {
    comparison_operator = var.notification_comparison_operator
    notification_type   = var.notification_type
    threshold           = var.notification_threshold
    threshold_type      = var.notification_threshold_type

    // TODO Conditional support SNS topics
    subscriber_email_addresses = var.notification_subscriber_value
  }

  // Bug in terraform for TagKeyValue, it doesn't support a list & the map keys overwrite each other while being processed.
  // https://github.com/hashicorp/terraform-provider-aws/issues/13288.
  cost_filters = var.budget_cost_filter
}

locals {
  time_period_start = var.time_period_start == null ? formatdate("YYYY-MM-DD_hh:mm", timestamp()) : var.time_period_start
}
