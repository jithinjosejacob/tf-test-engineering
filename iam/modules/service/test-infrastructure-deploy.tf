locals { 
    role_assumable_by_arns = [ 
        "arn:aws:iam::285858532195:root", 
        "arn:aws:iam::${var.account_id}:root", 
    ]
}

data "aws_region" "current" {}
data "aws_iam_policy_document" "deploy_role_access_grants" { 
    
    statement { 
        resources = [ 
            "*", 
        ] 
        actions = [ 
            "kms:Create*", 
            "kms:Describe*", 
            "kms:Enable*", 
            "kms:List*", 
            "kms:DescribeKey", 
            "kms:GenerateDataKey*", 
            "kms:Decrypt", 
            "kms:Put*", 
            "kms:Update*", 
            "kms:Revoke*", 
            "kms:Disable*", 
            "kms:Get*", 
            "kms:TagResource", 
            "kms:UntagResource", 
            "kms:ListResourceTags", 
            "kms:DeleteAlias", 
            "kms:ScheduleKeyDeletion" 
        ] 
    } 
    
    statement { 
        resources = [ 
            "arn:aws:s3:::testengineering*", 
            "arn:aws:s3:::testengineering*/*", 
        ] 
        
        actions = [ 
            "ec2:*", 
            "s3:*", 
            "s3:GetObject", 
            "s3:List", 
            "s3:PutObject", 
            "s3:PutBucket*", 
            "s3:PutItem", 
            "s3:PutBucketPolicy", 
            "s3:DeleteObject", 
            "s3:DeleteBucket", 
            "s3:PutEncryptionConfiguration", 
            "s3:ListAllMyBuckets", 
            "s3:CreateBucket", 
            "s3:PutLifecycleConfiguration", 
            "s3:PutMetricsConfiguration", 
            "s3:ReplicateTags", 
            "s3:ListBucketByTags" 
        ] 
    } 
    
    statement { 
        resources = ["*"] 
        actions = ["rds:DescribeGlobalClusters"] 
    }
    
}

module "deploy_role" { 
    source = "github.com/test-private/tf-module-iam-role.git"  //test-private-> org
    name_prefix = "testEngineeringInfrastructureDeploy" 
    iam_role_path = "/testengineering/" 
    create_pipeline_role = true 
    iam_policy_document = data.aws_iam_policy_document.deploy_role_access_grants.json 
    role_assumable_by_arns = local.role_assumable_by_arns 
    iam_boundaries_policy_document = "arn:aws:iam::${var.account_id}:policy/testEngineeringSeedBoundariesPolicy" 
    source_repo = var.source_repo 
    team = "test-engineering"
}