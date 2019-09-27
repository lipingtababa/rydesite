resource "aws_lambda_function" "web_lambda" {
	filename      = "./requestUnicorn.js.zip"
	function_name = "RequestUnicorn"
	role          = "${aws_iam_role.web_role.arn}"
	handler       = "exports.test"
	runtime	      = "nodejs8.10"

	environment {
		variables = {
			foo = "bar"
		}
	}
}
