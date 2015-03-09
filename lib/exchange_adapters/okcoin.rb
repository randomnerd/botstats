class ExchangeAdapters::Okcoin < ExchangeAdapters::Base
  include HTTParty
  base_uri 'https://www.okcoin.com/api/v1'

  def initialize(exchange)
    @exchange = exchange
  end

  def get_balances
    currencies = req_future_userinfo
    currencies.map do |curr, info|
      {
        'Currency' => curr.to_s.upcase,
        'Balance'  => info['account_rights'].to_f
      }
    end
  end

  def get_rate(curr)
    return 1 if curr.upcase == 'BTC'
    if curr.upcase == 'USD'
      urate = req_ticker("btc_usd").try(:[], 'last').try(:to_f)
      rate = 1/urate
    else
      rate = req_ticker("#{curr.downcase}_btc").try(:[], 'last').try(:to_f)
    end
    rate || 0
  end

  def params_string(req = {})
    params = []
    req.keys.sort.each do |key|
      params << "#{key}=#{req[key]}"
    end
    params.join '&'
  end

  def sign(req = {})
    sreq = req.clone
    sreq['secret_key'] = @exchange.api_secret || ''
    with_key = params_string(sreq)
    Digest::MD5.hexdigest(with_key).upcase
  end

  def prep_req(req)
    req['api_key'] = @exchange.api_key
    req['sign'] = sign req
    req
  end

  def req(method, params = {})
    signed_params = prep_req params
    resp = self.class.post "/#{method}.do", body: signed_params
    JSON.parse resp.parsed_response
  end

  def req_userinfo
    data = req 'userinfo'
    data['result'] ? data['info'].symbolize_keys : nil
  end

  def req_future_userinfo
    data = req 'future_userinfo'
    data['result'] ? data['info'].symbolize_keys : nil
  end

  def req_ticker(pair = 'btc_usd')
    data = JSON.parse self.class.get("/ticker.do?symbol=#{pair}")
    data['ticker'] ? data['ticker'] : nil
  end
end
