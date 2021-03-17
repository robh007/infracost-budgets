resource "aws_ecr_repository" "this" {
  name = "workload-2-repo"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = data.aws_subnet.this.id
}

resource "aws_eip" "this" {}

// This will use the default VPC in the Region & then find the default subnet in an AZ.
data "aws_vpc" "this" {
  default = true
}

data "aws_subnet" "this" {
  vpc_id = data.aws_vpc.this.id
  availability_zone_id = data.aws_availability_zones.this.zone_ids[0]
  default_for_az = true
}

data "aws_availability_zones" "this" {
  all_availability_zones = false
}