output "instances_id" {
  description = "EC2 instances"
  value      = tomap({
    for k, inst in aws_instance.pg_server : k => {
      id                = inst.id
      availability_zone = inst.availability_zone
      private_ip        = inst.private_ip
      public_ip         = inst.public_ip
    }
  })
}
