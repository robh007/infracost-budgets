resource "aws_budgets_budget" "this" {
  name_prefix = var.budget_name

  budget_type       = var.budget_type
  limit_amount      = fileexists(var.budget_estimate_file) ? jsondecode(file(var.budget_estimate_file))["totalMonthlyCost"] : var.budget_limit_amount
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

  dynamic "cost_filter" {
    for_each = var.budget_cost_filter
    content {
      name   = cost_filter.value.name
      values = [lookup(cost_filter("values"), null)]
    }
  }

}

locals {
  time_period_start = var.time_period_start == null ? formatdate("YYYY-MM-DD_hh:mm", timestamp()) : var.time_period_start
}
