resource "aws_kinesis_stream" "stock_trade_stream" {
  name                      = "StockTradeStream"
  shard_count               = 1
  enforce_consumer_deletion = true

  tags = {
    App = "amazon-kinesis-learning"
  }
}
