class ExchangeAdapters::BterAdapter < ExchangeAdapters::Base
  def initialize(exchange)
    @client        = ::Bter::Trade.new
    @client.key    = exchange.api_key
    @client.secret = exchange.api_secret
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
end
