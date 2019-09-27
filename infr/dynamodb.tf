#common parameters are stored in variables.tf

#The Dynamodb definition
resource "aws_dynamodb_table" "db" {
	name = "Rides"
	billing_mode= "PAY_PER_REQUEST"
	hash_key = "RideId"
	attribute {
		name = "RideId"
		type = "S"
		}

	server_side_encryption {
		enabled = false
		}

	point_in_time_recovery {
		enabled = false
		}

	#stream_enabled= false
	#stream_view_type = "NEW_AND_OLD_IMAGES"

	tags ={ usage = "rydesite" }

	}

#Output the ID and ARN
output "dynamodb_id" {
  value = ["${aws_dynamodb_table.db.id}"]
}

output "dynamodb_arn" {
  value = ["${aws_dynamodb_table.db.arn}"]
}

