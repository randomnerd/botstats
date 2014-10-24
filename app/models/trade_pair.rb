class TradePair < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :currency
  belongs_to :market, class_name: 'Currency'

  def name
    "#{currency.name} / #{market.name}"
  end

  def full_name
    "#{name} @ #{exchange.name}"
  end
end
