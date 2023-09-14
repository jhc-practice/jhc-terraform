# Retrieve the secret value from AWS Secrets Manager
data "aws_secretsmanager_secret" "my_database" {
  name = "jhcrdsdb"  # Replace with the name of your secret
}

data "aws_secretsmanager_secret_version" "my_database_version" {
  secret_id     = data.aws_secretsmanager_secret.my_database.id
}