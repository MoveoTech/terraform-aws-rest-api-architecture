variable "public_key" {
  description = "The public key api for atlas"
}
variable "private_key" {
  description = "The private key api for atlas"
}
variable "atlas_region" {
    default = "US_EAST_1"
    description = "Atlas region"
}
variable "aws_region" {
    default = "us-east-1"
    description = "Aws region"
}


variable "atlas_db_user" {
    default = "dave"
    description = "Atlas db user"
}
variable "atlas_db_password" {
    default = "123456"
    description = "Atlas db password"
}
variable "aws_account_id" {
    default = "821285884288"
    description = "AWS account id"
}
variable "atlas_org_id" {
    default = "62987fbbe0024e262a69c0c3"
    description = "Atlas org id"
}
variable "atlas_vpc_cidr" {
    default = "92.168.232.0/21"
    description = "Atlas vpc cidr"
}