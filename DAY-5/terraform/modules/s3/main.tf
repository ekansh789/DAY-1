
resource "aws_s3_bucket" "ekanshbucket" {
  bucket = "ekanshbucket"
  tags = {
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.ekanshbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.ekanshbucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate_block_public" {
  bucket = aws_s3_bucket.ekanshbucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}