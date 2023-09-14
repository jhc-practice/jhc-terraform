locals {
    username             = jsondecode(data.aws_secretsmanager_secret_version.my_database_version.secret_string)["username"]
    password = jsondecode(data.aws_secretsmanager_secret_version.my_database_version.secret_string)["password"]
}