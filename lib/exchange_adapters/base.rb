class ExchangeAdapters::Base
  attr_reader :client

  def update_balances
    cnt = 0
    get_balances.each do |balance|
      next unless curr = @exchange.currencies.find_by_name(balance['Currency'])
      b = (balance['Balance'] * 10 ** 8).round
      bb = curr.name.upcase == 'BTC' ? b : b * curr.rate / 10 ** 8
      curr.update_attribute :btc_balance, bb
      next if curr.balance.round == b.round
      curr.balance_changes.create(old_balance: curr.balance, new_balance: b)
      puts "#{curr.full_name} | #{curr.balance.to_f / 10 ** 8} => #{b.to_f / 10 ** 8}"
      curr.update_attribute :balance, b
      cnt += 1
    end
    @exchange.touch unless cnt == 0
    mean = @exchange.currencies.find_or_create_by(name: 'BTC-MEAN')
    mean.balance ||= 0
    b = @exchange.currencies.sum(:btc_balance)
    return if mean.balance == b
    mean.balance_changes.create(old_balance: mean.balance, new_balance: b)
    mean.update_attribute :balance, b
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
