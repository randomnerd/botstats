class ExchangeAdapters::Base
  def update_balances
    get_balances.each do |balance|
      next unless curr = @exchange.currencies.find_by_name(balance['Currency'])
      b = (balance['Balance'] * 10 ** 8).round
      unless curr.balance == b
        curr.balance_changes.create(old_balance: curr.balance, new_balance: b)
        puts "#{curr.full_name} | #{curr.balance.to_f / 10 ** 8} => #{b.to_f / 10 ** 8}"
        curr.update_attribute :balance, b
      end
    end
  end

  def fill_currencies(reset = false)
    balances = get_balances
    @exchange.currencies.delete_all if reset
    balances.each do |balance|
      unless reset
        next if @exchange.currencies.find_by_name(balance['Currency'])
      end
      b = (balance['Balance'] * 10 ** 8).round
      @exchange.currencies.create(
        name: balance['Currency'],
        balance: b,
        deposit_address: balance['CryptoAddress']
      )
    end
  end
end
