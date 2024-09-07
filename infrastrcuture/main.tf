terraform { 
    backend "s3" { 
        key = "terraform/tf-test-engineering-infra" 
        region = "ap-southeast-2" 
    } 
} 

provider "aws" { 
    region = "ap-southeast-2" 
    
default_tags { 
    tags = { 
        "testBoundary" = "testengineering" 
        "testTeam" = "test-engineering" 
        "owner" = "test-engineering" 
        "system" = "e2e-test-automation" 
        "source" = "tf-test-engineering-iam" 
        "testArtefact" = "tf-test-engineering-iam" 
        "testTaggingVersion" = "3.0.0" 
        } 
    } 
} 

data "aws_caller_identity" "current" {} 
    
module "kms_key" { 
    source = "./modules/kms-key" 
    aws_account_id = data.aws_caller_identity.current.account_id 
    account_id_dev = var.account_id_dev 
    account_id_stg = var.account_id_stg 
    account_id_prd = var.account_id_prd 
    additional_admin_role = var.additional_admin_role 
}