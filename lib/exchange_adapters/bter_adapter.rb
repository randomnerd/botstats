class ExchangeAdapters::BterAdapter < ExchangeAdapters::Base
  attr_reader :pclient

  def initialize(exchange)
    @client        = ::Bter::Trade.new
    @client.key    = exchange.api_key
    @client.secret = exchange.api_secret
    @pclient       = ::Bter::Public.new
    @exchange      = exchange
  end

  def get_balances
    info = @client.get_info
    h_balances  = info[:locked_funds]
    av_balances = info[:available_funds]
    av_balances.map do |curr, balance|
      {
        'Currency' => curr.to_s,
        'Balance'  => balance.to_f + (h_balances[curr].to_f || 0)
      }
    end
  end

  def get_rate(curr)
    return 1 if curr.upcase == 'BTC'
    if curr.upcase == 'USD'
      ticker = @pclient.ticker 'BTC_USD'
      urate = ticker.try(:[], :last).try(:to_f)
      rate = 1/urate
    else
      ticker = @pclient.ticker "#{curr.upcase}_BTC"
      rate = ticker.try(:[], :last).try(:to_f)
      # unless rate
      #   puts 'zzz'
      #   ticker = @pclient.ticker "#{curr.upcase}_LTC"
      #   rate = ticker.try(:[], :last).try(:to_f)
      # end
    end
    rate || 0
  end

end
