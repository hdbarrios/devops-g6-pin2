terraform {
  backend "s3" {
    bucket         = "tf-state-apache-bucket"         # Nombre del bucket
    key            = "apache-ec2/terraform.tfstate"   # Ruta del archivo state
    region         = "us-east-1"                      # Región del bucket
    dynamodb_table = "tf-apache-locks"                # Nombre de la tabla DynamoDB (para lock)
    encrypt        = false
  }
}
