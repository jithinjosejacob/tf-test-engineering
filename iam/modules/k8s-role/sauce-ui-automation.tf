data "aws_iam_policy_document" "sauce_ui_automation_k8s_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kms:List*",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:ScheduleKeyDeletion",
      "kms:CreateAlias"
    ]
    resources = [
      "arn:aws:kms:ap-southeast-2:${data.aws_caller_identity.current.account_id}:key/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersionAcl",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl",
    ]
    resources = [
      "arn:aws:s3:::qualityengineering-banking-ui-automation-${var.env}",
      "arn:aws:s3:::qualityengineering-banking-ui-automation-${var.env}/*"
    ]
  }
}


module "sauce_ui_automation_k8s_role" {
  source          = "github.com/test-private/tf-module-k8s-iam-role.git"
  name_prefix     = "BankingUIAutomation"
  path            = "/k8s/qualityengineering/"
  namespace       = "quality-engineering"
  team            = "quality-engineering"
  service_account = "banking-ui-automation"
  policy          = data.aws_iam_policy_document.sauce_ui_automation_k8s_role_policy.json
  boundary        = "QualityEngineering"
  clusters        = ["tap"]
}
