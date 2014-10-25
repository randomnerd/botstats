class Order < ActiveRecord::Base
  belongs_to :exchange
  belongs_to :currency
  belongs_to :market, class_name: 'Currency'
end
