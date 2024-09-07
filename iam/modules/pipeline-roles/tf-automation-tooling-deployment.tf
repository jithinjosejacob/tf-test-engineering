data "aws_kms_key" "default_ssm_key" {
  key_id = "alias/aws/ssm"
}

data "aws_iam_policy_document" "automation_tooling_deploy_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = ["arn:aws:iam::*:role/testEngineeringAutomationToolingDeployRole"]
  }

  statement {
    resources = [
      "*",
    ]

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ListResourceTags",
      "kms:DeleteAlias",
      "kms:ListAliases",
      "kms:ListKeys",
      "kms:GenerateRandom"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:ImportKeyMaterial",
      "kms:ListKeyPolicies",
      "kms:ListRetirableGrants",
      "kms:GetKeyPolicy",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:ListResourceTags",
      "kms:ReEncryptFrom",
      "kms:ListGrants",
      "kms:GetParametersForImport",
      "kms:TagResource",
      "kms:Encrypt",
      "kms:GetKeyRotationStatus",
      "kms:GenerateDataKey",
      "kms:ReEncryptTo",
      "kms:DescribeKey"
    ]
    resources = [
      "arn:aws:kms:ap-southeast-2:889592833949:key/55f71e50-40e4-4283-b604-5e4fb7e78811",
      "arn:aws:kms:ap-southeast-2:889592833949:key/e98604f7-3cb2-4e95-9471-b0803c69e6cd",
      "arn:aws:kms:ap-southeast-2:889592833949:key/7a101a5e-30d4-4e6c-99a4-23826019c5a7",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "s3:GetObject",
      "s3:PutObject",
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::testengineering*",
      "arn:aws:s3:::testengineering*/*",
    ]
  }
}

module "automation_tooling_deploy_role" {
  source                         = "github.com/test-private/tf-module-iam-role.git"
  name_prefix                    = "testEngineeringAutomationToolingDeploy"
  iam_role_path                  = "/testengineering/"
  iam_policy_document            = data.aws_iam_policy_document.automation_tooling_deploy_role.json
  create_pipeline_role           = true
  role_assumable_by_arns         = var.roles_assumable_by_arns
  iam_boundaries_policy_document = "arn:aws:iam::${var.aws_account_id}:policy/testEngineeringSeedBoundariesPolicy"
  source_repo                    = var.source_repo
  team                           = "test-engineering"
}
