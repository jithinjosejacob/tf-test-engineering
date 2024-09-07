data "aws_iam_policy_document" "kms_policy_document" { 
    statement { 
        sid = "Allow administration of kms key" 
    
        principals { 
            type = "AWS" 
            identifiers = ["arn:aws:iam::${var.aws_account_id}:role/Testengineering/TestEngineeringInfrastructureDeployRole"] 
        } 
    
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
            "kms:Delete*", 
            "kms:ScheduleKeyDeletion", 
            "kms:CancelKeyDeletion", 
            "kms:TagResource", 
            "kms:UntagResource", 
        ] 
    
        resources = ["*"] 
    } 

    statement { 
        sid = "Allow QE automation deploy role to use the key" 
        principals { 
            type = "AWS" 
            identifiers = [ 
            "arn:aws:iam::${var.aws_account_id}:role/Testengineering/TestEngineeringAutomationToolingDeployRole", 
            "arn:aws:iam::${var.aws_account_id}:role/k8s/Testengineering/DailyTxnApiAutomationRole", 
            "arn:aws:iam::${var.aws_account_id}:role/k8s/Testengineering/IntranetUIAutomationRole", 
            "arn:aws:iam::${var.aws_account_id}:role/k8s/Testengineering/SalesforceUIAutomationRole", 
            "arn:aws:iam::${var.account_id_dev}:role/TestEngineeringDevAdmin", 
            "arn:aws:iam::${var.account_id_stg}:role/TestEngineeringBreakGlass", 
            "arn:aws:iam::${var.account_id_prd}:role/TestEngineeringBreakGlass", 
            "arn:aws:iam::${var.account_id_dev}:role/Testengineering/TestEngineeringAutomationReportReader", 
            "arn:aws:iam::${var.account_id_stg}:role/Testengineering/TestEngineeringAutomationReportReader", 
            "arn:aws:iam::${var.account_id_prd}:role/Testengineering/TestEngineeringAutomationReportReader", 
            "arn:aws:iam::${var.account_id_dev}:role/Testengineering/TestEngineeringAutomationReportModifier", 
            "arn:aws:iam::${var.account_id_stg}:role/Testengineering/TestEngineeringAutomationReportModifier", 
            "arn:aws:iam::${var.account_id_prd}:role/Testengineering/TestEngineeringAutomationReportModifier", 
            ] 
    } 

        actions = [ 
            "kms:Encrypt", 
            "kms:GenerateDataKey*", 
            "kms:DescribeKey", 
            "kms:Decrypt", 
            "kms:ReEncrypt*", 
        ] 

        resources = ["*"] 
    }

}

module "kms_key" { 
    source = "github.com/jjj/tf-module-kms-key.git" 
    kms_key_alias_name = "alias/Testengineering-automation-key" 
    kms_key_description = "Key for Test-Engineering automation tasks" 
    kms_key_policy = data.aws_iam_policy_document.kms_policy_document.json 
    kms_key_admin_roles_arn = [ "arn:aws:iam::${var.aws_account_id}:role/Testengineering/TestEngineeringAutomationToolingDeployRole" 
    ]
}
