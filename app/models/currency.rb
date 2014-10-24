class Currency < ActiveRecord::Base
  belongs_to :exchange
  has_many :balance_changes

  def full_name
    "#{name} @ #{exchange.name}"
  end
end
