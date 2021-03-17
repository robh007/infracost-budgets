resource "aws_ecr_repository" "this" {
  name = "workload-1-repo"
}

resource "aws_eip" "this" {}
