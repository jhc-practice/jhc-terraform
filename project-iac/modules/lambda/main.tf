resource "aws_lambda_function" "example_lambda"{
  function_name = "lamba-func-demo"
  handler      = var.handler
  runtime      = var.run_time  
  filename =var.file_name
  role = aws_iam_role.lambda_exec_role.arn
} 

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# resource "aws_iam_policy_attachment" "lambda_exec_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
#   roles      = [aws_iam_role.lambda_exec_role.name]
