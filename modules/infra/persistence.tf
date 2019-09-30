#
# EBS Resources for persistence
#


# NOTE: AZ is hardcoded to index 0
resource "aws_ebs_volume" "persistence" {
  count = var.persistence_ebs_volumes_count
  availability_zone = data.aws_availability_zones.available.names[0]
  size = var.persistence_ebs_volumes_size

  tags = {
    Name = "tf-${var.cluster_name}-${count.index}"
  }
}
