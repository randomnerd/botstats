class ExchangeAdapters::Bittrex < ExchangeAdapters::Base
  def initialize(exchange)
    @client   = Bittrex::Client.new(key: exchange.api_key, secret: exchange.api_secret)
    @exchange = exchange
  end

  def get_balances
    @client.get('account/getbalances')
  end
end
