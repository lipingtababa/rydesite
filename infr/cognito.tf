
resource "aws_cognito_user_pool" "pool" {
	name = "rydesite"
}

resource "aws_cognito_user_pool_client" "client" {
	name = "site_client"
	generate_secret = false
	user_pool_id = "${aws_cognito_user_pool.pool.id}"
}

output "user_pool_id"{
	value = "${aws_cognito_user_pool_client.client.id}"
}
