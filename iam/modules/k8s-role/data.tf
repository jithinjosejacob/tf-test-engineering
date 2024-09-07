data "aws_kms_key" "default_ssm_key" {
    key_id = "alias/aws/ssm"
}

data "aws_caller_identity" "current" {}