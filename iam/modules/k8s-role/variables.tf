variable "aws_account_id" {
    description = "The id of the account"
}

variable "env" {
    description = "Tyro environment this bucket will reside in"
}

variable "source_repo" {
    description = "The source repo defined by the Github"
}

variable "tap_odic_subject_prefix" {
    description = "value of the oidc subject prefix"
    default = "oidc.eks.ap-southeast-2.amazonaws.com/id/2DD88888UUUUU:sub"
}