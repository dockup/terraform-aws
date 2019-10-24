#####
# DB
#####
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  identifier = "${var.cluster_name}-rds-postgres"

  engine            = "postgres"
  engine_version    = "9.5"
  instance_class    = "db.t2.large"
  allocated_storage = 5
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "dockup_ui_prod"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = var.pg_user

  password = var.pg_password
  port     = var.pg_port

  vpc_security_group_ids = ["${aws_security_group.eks-cluster.id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Owner       = "user"
    Environment = "prod"
  }

  # DB subnet group
  subnet_ids = "${aws_subnet.eks-cluster[*].id}"

  # DB parameter group
  family = "postgres9.5"

  # DB option group
  major_engine_version = "9.5"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "${var.cluster_name}-rds-postgres-snapshot"

  # Database Deletion Protection
  deletion_protection = false
}
