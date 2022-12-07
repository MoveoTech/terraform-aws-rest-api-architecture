data "aws_elastic_beanstalk_solution_stack" "solution_stack_name" {
  most_recent = true

  name_regex = var.aws_elastic_beanstalk_solution_stack
}
