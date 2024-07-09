module "sns" {
  source = "./modules/sns"

  name                = local.sns.topic_name
  fifo_topic          = local.sns.fifo_topic
  create_topic_policy = true
  subscriptions       = local.sns.subscriptions

  topic_policy_statements = {
    TrustCWEToPublishEvents = {
      actions = ["sns:Publish"]
      principals = [{
        type        = "Service"
        identifiers = ["events.amazonaws.com"]
      }]
      resources = [module.sns.aws_sns_topic_arn]
      effect    = "Allow"
      sid       = "TrustCWEToPublishEventsToMyTopic"
    },
    TrustCloudWatchToPublish = {
      actions = ["sns:Publish"]
      principals = [{
        type        = "Service"
        identifiers = ["cloudwatch.amazonaws.com"]
      }]
      resources = [module.sns.aws_sns_topic_arn]
      effect    = "Allow"
      sid       = "TrustCloudWatchToPublishToMyTopic"
    }
  }

  tags = local.tags

}
