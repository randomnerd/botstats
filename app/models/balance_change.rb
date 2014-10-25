class BalanceChange < ActiveRecord::Base
  belongs_to :currency
  scope :since, -> ts {
    where('balance_changes.created_at >= ?', ts).
    order('balance_changes.created_at')
  }
  scope :recent, -> { since(1.week.ago) }
end
