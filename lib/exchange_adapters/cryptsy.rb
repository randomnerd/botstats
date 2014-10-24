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
end
