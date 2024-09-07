variable "account_id" {
    description = "The id of the account"
}

variable "buildkite_iam_arn" {
    description = "The buildkite IAM role ARN that will assume the role to provision resources into the account"
}