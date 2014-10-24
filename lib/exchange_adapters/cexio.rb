class ExchangeAdapters::Cexio < ExchangeAdapters::Base
  def initialize(exchange)
    @exchange = exchange
    @client   = CEX::API.new(exchange.username, exchange.api_key, exchange.api_secret)
  end

  def get_balances
    currencies = @client.balance
    currencies.delete 'timestamp'
    currencies.delete 'username'
    currencies.map do |curr, info|
      {
        'Currency' => curr,
        'Balance'  => info['available'].to_f + info['orders'].to_f
      }
    end
  end
end
