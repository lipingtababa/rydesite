
#Define a user role for Lambda function to write into Dynamodb, CloudWatch

# Create a role and specify that it could be assumed by lambda
resource "aws_iam_role" "web_role"{
	name = "web_role"
	tags = {usage="rydesite"}
	assume_role_policy = <<EOF
{
	"Version":"2012-10-17",
	"Statement" : [
		{
		"Action":["sts:AssumeRole"],
		"Principal":{
			"Service":"lambda.amazonaws.com"
		},
		"Effect":"Allow"
		}
	]
}
EOF
}

# Create a policy that authorize writing into CloudWatch
resource "aws_iam_policy" "web_cloudwatch_policy"{
	name = "web_cloudwatch_policy"
	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the cloudwatch policy to the role
resource "aws_iam_role_policy_attachment" "web_role_cloudwatch_policy_attachment" {
	role       = "${aws_iam_role.web_role.name}"
	policy_arn = "${aws_iam_policy.web_cloudwatch_policy.arn}"
}

# Create a policy that authorize writing into dynamodb
resource "aws_iam_policy" "web_dynamodb_policy"{
	name = "web_dynamodb_policy"
	policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "${aws_dynamodb_table.db.arn}"
    }
  ]
}
EOF
}

# Attach the dynamodb policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy_to_stream_writer_role" {
	role       = "${aws_iam_role.web_role.name}"
	policy_arn = "${aws_iam_policy.web_dynamodb_policy.arn}"
}

output "web_role_arn"{
	value = "${aws_iam_role.web_role.arn}"
}
