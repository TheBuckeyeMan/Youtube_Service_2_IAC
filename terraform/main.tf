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
      Api_Key = var.API_KEY
    }
  }

  timeout = 30 #Adjust the timeout of the function IN SECONDS
  memory_size = 512 #Adjust the Memory of the function
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name = aws_lambda_function.api_lambda.function_name #Gives the AWS Lambda function a URL for us to trigger
  authorization_type = "NONE"
}

##Add in additional code for AWS Event bridge, or API Gateway here for Lambda Deployment