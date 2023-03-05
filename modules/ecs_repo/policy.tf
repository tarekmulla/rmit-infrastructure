data "aws_caller_identity" "current" {}

# Provide permission for aws account to access private ECR, and pull the image
resource "aws_ecr_repository_policy" "aws_account_access" {
  depends_on = [
    aws_ecr_repository.repo
  ]
  repository = var.app
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "allow-aws-access-ecr",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })
}
