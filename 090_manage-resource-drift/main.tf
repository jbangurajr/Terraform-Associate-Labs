terraform apply -replace=aws_instance.my_server

terraform apply -refresh-only

terraform import aws_s3_bucket.<resource_name> <bucket_name>