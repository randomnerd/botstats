class BalanceChange < ActiveRecord::Base
  belongs_to :currency
  has_one :exchange, through: :currency
  scope :since, -> ts {
    where('balance_changes.created_at >= ?', ts).
    order('balance_changes.created_at')
  }
  scope :recent, -> { since(1.day.ago) }

  rails_admin do
    weight +1
    list do
      field :exchange
      field :currency
      field :change do
        formatted_value do
          o = bindings[:object]
          d = o.new_balance - o.old_balance
          "%.8f" % (d.to_f / 10 ** 8)
        end
      end
      field :new_balance do
        formatted_value do
          "%.8f" % (value.to_f / 10 ** 8)
        end
      end
      field :created_at
    end
  end

end
