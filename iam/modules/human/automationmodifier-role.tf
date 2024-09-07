resource "aws_iam_role" "automation_report_modifier_role" { 
    name = "testEngineeringAutomationReportModifier" 
    path = "/testengineering/" 
    permissions_boundary = "arn:aws:iam::${var.account_id}:policy/testEngineeringSeedBoundariesPolicy" 
    assume_role_policy = data.aws_iam_policy_document.automation_report_modifier_role.json 
    description = "Created by tf-test-engineering-iam repo" 
    tags = { 
        source_repo = var.source_repo 
        team = "test-engineering" 
    } 
} 
    
resource "aws_iam_role_policy_attachment" "automation_report_modifier_read_only_attachment" { 
    role = aws_iam_role.automation_report_modifier_role.name 
    policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess" 
} 

resource "aws_iam_role_policy" "automation_report_modifier_allow_s3" { 
    name = "AllowAutmationModifierS3ModifyAccess" 
    role = aws_iam_role.automation_report_modifier_role.name 
    policy = data.aws_iam_policy_document.allow_automation_report_modifier_s3.json 
} 

data "aws_iam_policy_document" "allow_automation_report_modifier_s3" { 
    statement { 
        effect = "Allow" 
        actions = [
            "s3:List*", 
            "s3:Get*", 
            "s3:PutObject"
        ] 
        resources = [ 
            "arn:aws:s3:::testengineering*", 
            "arn:aws:s3:::testengineering*/*", 
        ] 
    } 
    
    statement { 
        effect = "Allow" 
        actions = [ 
            "kms:List*", 
            "kms:Get", 
            "kms:Delete", 
            "kms:Encrypt", 
            "kms:Decrypt", 
            "kms:ReEncrypt*", 
            "kms:GenerateDataKey*", 
            "kms:DescribeKey", 
            "kms:ScheduleKeyDeletion", 
            "kms:CreateAlias" 
        ] 
        
        resources = [ 
            "arn:aws:kms:ap-southeast-2:889592833949:key/82ca1dd2-10e3-47fc-8f97-d39efe3c55bb", 
            "arn:aws:kms:ap-southeast-2:778082898154:key/7164a9a3-e82a-4747-9b16-164f249ed886" 
        ] 
    } 
} 

data "aws_iam_policy_document" "automation_report_modifier_role" { 
    source_json = data.aws_iam_policy_document.assume_role_common.json 
    statement { 
        effect = "Allow" 
        actions = ["sts:AssumeRole"] 
        principals {
            type = "AWS" 
            identifiers = ["arn:aws:iam::${var.account_id_identity}:role/testEngineeringAutomationReportModifier"] 
        } 
    } 
}