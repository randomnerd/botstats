collection @balance_changes.includes(:currency)
node(:name) { |bc| bc.currency.name }
node(:time) { |bc| bc.created_at.to_i * 1000 }
node(:balance) { |bc| bc.new_balance.to_f / 10 ** 8 }
# attributes :new_balance, :created_at
