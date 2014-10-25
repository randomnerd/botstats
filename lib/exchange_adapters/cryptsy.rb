class ExchangeAdapters::Cryptsy < ExchangeAdapters::Base
  def initialize(exchange)
    @exchange = exchange
    @client   = Cryptsy::Client.new(exchange.api_key, exchange.api_secret)
  end

  def get_balances
    balances = {}
    h_balances = @client.info.balances_hold
    a_balances = @client.info.balances_available
    a_balances.each do |curr, b|
      balances[curr] = b.to_f + (h_balances[curr] || 0).to_f
    end
    balances.map do |curr, balance|
      {
        'Currency' => curr,
        'Balance'  => balance
      }
    end
  end

  def get_rate(curr)
    return 1 if curr.upcase == 'BTC'
    if curr.upcase == 'USD'
      urate = @client.market_by_pair('BTC', 'USD').try(:[], 'last_trade').try(:to_f)
      rate = 1/urate
    else
      rate = @client.market_by_pair(curr.upcase, 'BTC').try(:[], 'last_trade').try(:to_f)
    end
    rate || 0
  end
end
