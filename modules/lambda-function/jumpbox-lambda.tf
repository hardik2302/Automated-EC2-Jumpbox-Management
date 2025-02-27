resource "aws_lambda_function" "stop_jumpboxes" {
  function_name = "ec2-jumpbox-automation"
  package_type  = "Image"
  image_uri     = "${var.lambda_ecr_details.repository_url}:ec2-jumpbox-automation"

  role = aws_iam_role.lambda_exec_role.arn

  skip_destroy = false //Set to true if you do not wish the function to be deleted at destroy time, and instead just remove the function from the Terraform state.
  timeout = 900
}

resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "stop-jumpboxes-schedule"
  schedule_expression = "cron(0 22 * * ? *)" # 10 PM UTC daily
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "lambda"
  arn       = aws_lambda_function.stop_jumpboxes.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_jumpboxes.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
}