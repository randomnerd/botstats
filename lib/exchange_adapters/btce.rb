class ExchangeAdapters::Btce < ExchangeAdapters::Base
  def initialize(exchange)
    @client   = Btce::TradeAPI.new(key: exchange.api_key, secret: exchange.api_secret)
    @exchange = exchange
  end

  def get_balances
    h_balances  = calc_hold
    av_balances = @client.get_info['return']['funds']
    av_balances.map do |curr, balance|
      {
        'Currency' => curr,
        'Balance'  => balance + (h_balances[curr] || 0)
      }
    end
  end

  def calc_hold
    hold = {}
    get_orders.each do |id, info|
      currency, market = info['pair'].split '_'
      hold[market]   ||= 0
      hold[currency] ||= 0
      case info['type']
      when 'buy'
        hold[market] += info['amount'] * info['rate']
      when 'sell'
        hold[currency] += info['amount']
      end
    end
    hold
  end

  def get_orders
    @client.order_list['return']
  end
end
