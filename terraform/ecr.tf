resource "aws_ecr_repository" "clearpoint-backend" {
  name = "${local.common_tags.Project_Name}-backend"
  tags = local.common_tags
}

resource "aws_ecr_repository" "clearpoint-frontend" {
  name = "${local.common_tags.Project_Name}-frontend"
  tags = local.common_tags
}