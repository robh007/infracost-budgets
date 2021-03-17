variable "budget_name" {
  description = "Name of the budget to create"
  default     = ""

  type = string
}

variable "budget_list" {
  description = "A list of names that need a budget creating, if using infracost output set to name of module that created the file"
  default = []

  type = list
}

variable "budget_type" {
  description = "Type of Budget, tracks either monetary cost or usage"
  default     = "COST"

  type = string
}

variable "budget_limit_amount" {
  description = "Value of the budget as a number"
  default     = 0

  type = number
}

variable "budget_limit_unit" {
  description = "Limit in USD or GB"
  default     = "USD"

  type = string
}

variable "time_period_end" {
  description = "When the budget ends this isn't a requried parameter"
  default     = null

  type = string
}

variable "time_period_start" {
  description = "When the budget period starts, "
  default     = null

  type = string
}

variable "time_unit" {
  description = "Amount of time until the budget resets actual forecasted spend"
  default     = "MONTHLY"

  type = string
}

variable "notification_threshold_type" {
  description = "What kind of threshold is defined"
  default = "ABSOLUTE_VALUE"
}

variable "notification_threshold" {
  description = "Threshold when the notifcation be sent"
  default = 0
}

variable "notification_comparison_operator" {
  description = "Comparison Operator, used to evaluate condition"
  default = "EQUAL_TO"
}

variable "notification_type" {
  description = "What Kind of budget value to notify on."
  default = "ACTUAL"
}

variable "notification_subscriber_value" {
  description = "Email address or SNS Topic"
  default = []

  type = list(string)
}

variable "budget_cost_filter" {
  description = "Filters to use when creating a budget"
  default = {}

  type = map(string)
}