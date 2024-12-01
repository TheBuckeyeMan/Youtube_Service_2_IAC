data "aws_ecr_image" "latest_image" {
  repository_name = "youtube-containers"
  image_tag       = "youtube-service-2"
}

data "aws_iam_role" "existing_lambda_role" {
  name = "lambda_role_for_s3_access" #Name of the iam role that gives your lambda permissions
}

resource "aws_lambda_function" "api_lambda" {
  function_name = "youtube-service-2"
  role          = data.aws_iam_role.existing_lambda_role.arn

  package_type = "Image"
  image_uri    = "${data.aws_ecr_image.latest_image.image_uri}"

  environment {
    variables = {
      API_KEY = var.API_KEY
      AWS_BASIC_BUCKET = var.AWS_BASIC_BUCKET
      AWS_BASIC_BUCKET_KEY = var.AWS_BASIC_BUCKET_KEY
      GPT_URL = var.GPT_URL
      GPT_BUCKET_NAME = var.GPT_BUCKET_NAME
      GPT_BUCKET_KEY = var.GPT_BUCKET_KEY
      LOGGING_BUCKET_NAME = var.LOGGING_BUCKET_NAME
      LOGGING_BUCKET_KEY = var.LOGGING_BUCKET_KEY
    }
  }

  timeout = 60 #Adjust the timeout of the function IN SECONDS
  memory_size = 512 #Adjust the Memory of the function

}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name #Gives the AWS Lambda function a URL for us to trigger
  authorization_type = "NONE"
}

# Grant permission for youtube-job-verification to invoke youtube-service-2
resource "aws_lambda_permission" "allow_invocation_from_youtube_job_verification" {
  statement_id  = "AllowInvocationFromYoutubeJobVerification"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_lambda.function_name
  principal     = "lambda.amazonaws.com"
  source_arn    = data.aws_iam_role.existing_lambda_role.arn # ARN of the IAM role of youtube-job-verification
}

