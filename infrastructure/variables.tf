variable "access_key" {
    type = string
    sensitive = true
}
variable "secret_key" {
    type = string
    sensitive = true
}
variable "region" {
    type = string
    sensitive = true
}
variable "ami_id" {
    type = string
    sensitive = true
}
variable "instance_type" {
    type = string
    sensitive = true
}
variable "av_zone" {
    type = string
    sensitive = true
}
variable "key_name" {
    type = string
    sensitive = true
}
variable "db_password" {
    type = string
    sensitive = true
}