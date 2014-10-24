class TradePair < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :currency
  belongs_to :market, class_name: 'Currency'

  def name
    "#{currency.try :name} / #{market.try :name}"
  end

  def full_name
    "#{name} @ #{exchange.try :name}"
  end
end
