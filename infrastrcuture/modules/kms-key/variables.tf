variable "aws_account_id" { 
    description = "Account ID of the account to deploy into" 
} 

variable "account_id_dev" { 
    description = "The development account id the buildkite agent resides in" 
} 

variable "account_id_stg" { 
    description = "The staging account id the buildkite agent resides in" 
} 

variable "account_id_prd" { 
    description = "The production account id the buildkite agent resides in" 
} 

variable "additional_admin_role" { 
    type = string 
    description = "Additional admin role to be granted KMS access" 
    default = "" 
}
