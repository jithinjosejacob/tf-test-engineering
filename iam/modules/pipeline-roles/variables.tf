variable "aws_account_id" {
    description = "Account ID of the aws account to deploy onto"
}

variable "roles_assumable_by_arns" {
    description = "List of ARNs that can assume roles created in this repository"
    default = list(string)
}

variable "source_repo" {
    description = "The source repo defined by the Github"
}