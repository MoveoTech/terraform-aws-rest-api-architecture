
resource "random_string" "random" {
  length  = 5
  special = false
  numeric = true
  upper   = true
}

module "cloudwatch_log_group" {
  source      = "cloudposse/cloudwatch-logs/aws"
  version     = "0.6.8"
  kms_key_arn = var.kms_key_arn
  context = merge(var.context,
    {
      namespace   = "",
      stage       = "",
      environment = "",
      name        = "aws-waf-logs-${var.context.stage}-${var.type}-${random_string.random.result}"
  })
}


module "waf" {
  source                    = "cloudposse/waf/aws"
  version                   = "1.4.0"
  association_resource_arns = var.association_resource_arns
  scope                     = var.scope
  default_action            = "allow"
  log_destination_configs   = [module.cloudwatch_log_group.log_group_arn]
  managed_rule_group_statement_rules = [

    {
      name            = "rule-10"
      override_action = "none"
      priority        = 10

      statement = {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"

        excluded_rule = []
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-10-metric"
      }
    },
    {
      name            = "rule-12"
      override_action = "none"
      priority        = 12

      statement = {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"

        excluded_rule = []
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-12-metric"
      }
    },

    {
      name            = "rule-13"
      override_action = "none"
      priority        = 13

      statement = {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"

        excluded_rule = []
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-13-metric"
      }
    },
    {
      name            = "rule-14"
      override_action = "none"
      priority        = 14

      statement = {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"

        excluded_rule = []
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-14-metric"
      }
    },
    # {
    #   name            = "rule-15"
    #   override_action = "none"
    #   priority        = 15

    #   statement = {
    #     name        = "AWSManagedRulesATPRuleSet"
    #     vendor_name = "AWS"

    #     excluded_rule = []
    #   }

    #   visibility_config = {
    #     cloudwatch_metrics_enabled = true
    #     sampled_requests_enabled   = true
    #     metric_name                = "rule-15-metric"
    #   }
    # },
    {
      name            = "rule-20"
      override_action = "none"
      priority        = 20

      statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule = [
          "SizeRestrictions_QUERYSTRING",
          "NoUserAgent_HEADER"
        ]
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-20-metric"
      }
    },
    {
      name            = "rule-21"
      override_action = "none"
      priority        = 21

      statement = {
        name        = "AWSManagedRulesBotControlRuleSet"
        vendor_name = "AWS"

        excluded_rule = []
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-21-metric"
      }
    }

  ]

  byte_match_statement_rules = [
    {
      name     = "rule-30"
      action   = "allow"
      priority = 30

      statement = {
        positional_constraint = "EXACTLY"
        search_string         = "/cp-key"

        text_transformation = [
          {
            priority = 30
            type     = "COMPRESS_WHITE_SPACE"
          }
        ]

        field_to_match = {
          uri_path = {}
        }
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-30-metric"
      }
    }
  ]

  rate_based_statement_rules = [
    {
      name     = "rule-40"
      action   = "block"
      priority = 40

      statement = {
        limit              = 10000
        aggregate_key_type = "IP"
      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-40-metric"
      }
    }
  ]

  size_constraint_statement_rules = [
    {
      name     = "rule-50"
      action   = "block"
      priority = 50

      statement = {
        comparison_operator = "GT"
        size                = 15

        field_to_match = {
          all_query_arguments = {}
        }

        text_transformation = [
          {
            type     = "COMPRESS_WHITE_SPACE"
            priority = 1
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-50-metric"
      }
    }
  ]

  xss_match_statement_rules = [
    {
      name     = "rule-60"
      action   = "block"
      priority = 60

      statement = {
        field_to_match = {
          uri_path = {}
        }

        text_transformation = [
          {
            type     = "URL_DECODE"
            priority = 1
          },
          {
            type     = "HTML_ENTITY_DECODE"
            priority = 2
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-60-metric"
      }
    }
  ]

  sqli_match_statement_rules = [
    {
      name     = "rule-70"
      action   = "block"
      priority = 70

      statement = {

        field_to_match = {
          query_string = {}
        }

        text_transformation = [
          {
            type     = "URL_DECODE"
            priority = 1
          },
          {
            type     = "HTML_ENTITY_DECODE"
            priority = 2
          }
        ]

      }

      visibility_config = {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = "rule-70-metric"
      }
    }
  ]

  context = var.context
}
