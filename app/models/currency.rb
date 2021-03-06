class Currency < ActiveRecord::Base
  belongs_to :exchange
  has_many :balance_changes

  rails_admin do
    list do
      field :id
      field :exchange
      field :name
      field :balance do
        formatted_value do
          "%.8f" % (value.to_f / 10 ** 8)
        end
      end
      field :rate do
        formatted_value do
          "%.8f" % (value.to_f / 10 ** 8)
        end
      end
      field :btc_balance do
        formatted_value do
          "%.8f" % (value.to_f / 10 ** 8)
        end
      end
      field :updated_at
    end
  end

  def full_name
    "#{name} @ #{exchange.name}"
  end
end
