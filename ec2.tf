################################################################################
# EC2 Module for EC2
################################################################################

module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.6.1"
  name                        = local.ec2.ec2_name
  ami                         = local.ec2.ec2_ami
  instance_type               = local.ec2.instance_type
  subnet_id                   = local.ec2.subnet_id
  vpc_security_group_ids      = local.ec2.vpc_security_group_ids
  iam_role_name               = local.ec2.iam_role_name
  iam_role_description        = local.ec2.ec2_name
  hibernation                 = var.hibernation
  associate_public_ip_address = var.associate_public_ip_address
  disable_api_stop            = var.disable_api_stop
  create_iam_instance_profile = var.create_iam_instance_profile
  iam_instance_profile        = local.ec2.iam_instance_profile
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    s3Access                     = aws_iam_policy.s3_read_policy.arn
    SecretsManagerReadWrite      = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  }
  monitoring                  = var.monitoring
  user_data_replace_on_change = var.user_data_replace_on_change
  user_data_base64            = base64encode(var.user_data)

  root_block_device = [
    {
      volume_type = var.root_volume_type
      volume_size = var.root_volume_size
      throughput  = var.root_throughput
      encrypted   = true
    }
  ]
}

################################################################################
# aws eip
################################################################################
resource "aws_eip" "ec2" {
  instance = module.ec2.id
  domain   = "vpc"
}


resource "null_resource" "ansible_provisioner" {

  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    always_run = timestamp()
  }


  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook  -v ansible/install.yml -i ansible/aws_ec2.yml  --extra-vars ' migration_bucket=${data.aws_s3_bucket.asset_bucket.id} rds_endpoint=${module.rds.db_instance_endpoint} secrets_arn=${module.secrets_manager.secret_arn} region=${var.region} ' "
  }
  depends_on = [module.ec2, module.rds, module.secrets_manager]
}
