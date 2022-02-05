provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

module "lambda_at_edge" {
  source = "cloudposse/cloudfront-s3-cdn/aws//modules/lambda@edge"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.82.2"

  functions = {
    origin_request = {
      source = [{
        content  = <<-EOT
        'use strict';

        exports.handler = (event, context, callback) => {

          //Get contents of response
          const response = event.Records[0].cf.response;
          const headers = response.headers;

          //Set new headers
          headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age=63072000; includeSubdomains; preload'}];
          headers['content-security-policy'] = [{key: 'Content-Security-Policy', value: "default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'"}];
          headers['x-content-type-options'] = [{key: 'X-Content-Type-Options', value: 'nosniff'}];
          headers['x-frame-options'] = [{key: 'X-Frame-Options', value: 'DENY'}];
          headers['x-xss-protection'] = [{key: 'X-XSS-Protection', value: '1; mode=block'}];
          headers['referrer-policy'] = [{key: 'Referrer-Policy', value: 'same-origin'}];

          //Return modified response
          callback(null, response);
        };
        EOT
        filename = "index.js"
      }]
      runtime      = "nodejs12.x"
      handler      = "index.handler"
      event_type   = "origin-response"
      include_body = false
    }
  }

  # An AWS Provider configured for us-east-1 must be passed to the module, as Lambda@Edge functions must exist in us-east-1
  providers = {
    aws = aws.us-east-1
  }

  context = var.context
}

