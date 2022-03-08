data "aws_elastic_beanstalk_solution_stack" "solution_stack_name" {
  most_recent = true

  name_regex = "^64bit Amazon Linux (.*) running Node.js (.*)$"
}
