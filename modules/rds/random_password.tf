################################################################################
# Creation of random_password resource
################################################################################
resource "random_password" "master_password" {
  count = local.create_random_password ? 1 : 0

  length  = var.random_password_length
  special = false #set true to allow the usages of apecial characters in the password
}
