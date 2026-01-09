output "instance_profile_name"{
    value = aws_iam_instance_profile.ec2_profile.name
    description = "EC2-instance profile name"
}

output "role_name" {
  value = aws_iam_role.ec2_role.name
  description = "IAM role name for EC2"
}