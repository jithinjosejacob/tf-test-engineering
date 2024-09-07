data "aws_kms_key" "default_ssm_key" {
    key_id = "alias/aws/ssm"
}