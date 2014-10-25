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

  def get_rate(curr)
    return 1 if curr.upcase == 'BTC'
    if curr.upcase == 'USD'
      urate = @client.ticker("BTC/USD").try(:[], 'last').try(:to_f)
      rate = 1/urate
    else
      rate = @client.ticker("#{curr.upcase}/BTC").try(:[], 'last').try(:to_f)
    end
    rate || 0
  end
end
