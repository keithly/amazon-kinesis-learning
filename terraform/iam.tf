resource "aws_iam_policy" "StockTradeStream_policy" {
  name        = "StockTradeStreamPolicy"
  description = "created for the amazon-kinesis-learning tutorial"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetRecords",
        "kinesis:GetShardIterator",
        "kinesis:PutRecord",
        "kinesis:PutRecords",
        "kinesis:ListShards",
        "kinesis:DescribeStreamSummary",
        "kinesis:RegisterStreamConsumer"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:kinesis:us-east-2:909206842211:stream/StockTradeStream"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:SubscribeToShard",
        "kinesis:DescribeStreamConsumer"
      ],
      "Resource": [
        "arn:aws:kinesis:us-east-2:909206842211:stream/StockTradeStream/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws:dynamodb:us-east-2:909206842211:table/StockTradesProcessor"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "up_attachment" {
  user       = aws_iam_user.StockTradeStream_user.name
  policy_arn = aws_iam_policy.StockTradeStream_policy.arn
}

resource "aws_iam_user" "StockTradeStream_user" {
  name = "StockTradeStreamUser"
  force_destroy = true

  tags = {
    App = "amazon-kinesis-learning"
  }
}
