# module "route53_hosted_zone" {
#   source = "./modules/zones"

#   zones = {
#     (local.route53.hosted_zone_name) = {
#       comment = "${local.route53.hosted_zone_name} (production)"
#       tags = {
#         Name = local.route53.hosted_zone_name
#       }
#     }
#   }
# }
