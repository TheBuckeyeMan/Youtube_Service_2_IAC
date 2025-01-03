variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "region" {
    description = "Desired Region"
    type = string
    default = "us-east-2"
}
variable "API_KEY" {
  description = "API Key"
  type = string
}
variable "AWS_BASIC_BUCKET" {
  description = "AWS_BASIC_BUCKET"
  type = string
}
variable "AWS_BASIC_BUCKET_KEY" {
  description = "AWS_BASIC_BUCKET_KEY"
  type = string
}
variable "GPT_URL" {
  description = "GPT_URL"
  type = string
}
variable "GPT_BUCKET_NAME" {
  description = "GPT_BUCKET_NAME"
  type = string
}
variable "GPT_BUCKET_KEY" {
  description = "GPT_BUCKET_KEY"
  type = string
}
variable "LOGGING_BUCKET_NAME" {
  description = "LOGGING_BUCKET_NAME"
  type = string
}
variable "LOGGING_BUCKET_KEY" {
  description = "LOGGING_BUCKET_KEY"
  type = string
}
variable "AWS_REGION" {
  description = "AWS_REGION"
  type = string
}

variable "TAGS_BUCKET_KEY" {
  description = "TAGS_BUCKET_KEY"
  type = string
}