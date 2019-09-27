resource "aws_lambda_function" "web_lambda_function" {
	filename      = "././index.js.zip"
	function_name = "unicorn"
	role          = "${aws_iam_role.web_role.arn}"
	handler       = "index.handler"
	runtime	      = "nodejs8.10"

	environment {
		variables = {
			foo = "bar"
		}
	}
	tags = {usage="rydesite"}
}
