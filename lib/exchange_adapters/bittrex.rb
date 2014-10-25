class ExchangeAdapters::Bittrex < ExchangeAdapters::Base
  def initialize(exchange)
    @client   = Bittrex::Client.new(key: exchange.api_key, secret: exchange.api_secret)
    @exchange = exchange
  end

  def get_balances
    @client.get('account/getbalances')
  end

  def get_rate(curr)
    return 1 if curr.upcase == 'BTC'
    data = @client.get('public/getticker', market: "BTC-#{curr.upcase}")
    if data
      rate = data.try(:[], 'Last') || 0
    else
      data = @client.get('public/getticker', market: "LTC-#{curr.upcase}")
      if data
        lrate = data.try(:[], 'Last') || 0
        puts "LRATE: #{lrate}"
        rate = @exchange.currencies.find_by_name('LTC').rate * lrate / 10 ** 8
      end
    end
    rate || 0
  end
end
