class Exchange < ActiveRecord::Base
  has_many :trade_pairs
  has_many :currencies
  has_many :balance_changes, through: :currencies

  rails_admin do
    weight -1
    list do
      field :id
      field :name
      field :enable_updates
    end
    edit do
      field :name
      field :api_key
      field :api_secret
      field :username
      field :enable_updates
    end
  end

  def self.run_updates
    where(enable_updates: true).pluck(:id).each do |ex|
      ExchangeUpdater.perform_async(ex)
    end
  end

  def adapter
    return @adapter if @adapter
    case api_adapter
    when 'bittrex' then return ::ExchangeAdapters::Bittrex.new(self)
    when 'cryptsy' then return ::ExchangeAdapters::Cryptsy.new(self)
    when 'cexio'   then return ::ExchangeAdapters::Cexio.new(self)
    when 'btce'    then return ::ExchangeAdapters::Btce.new(self)
    when 'bter'    then return ::ExchangeAdapters::BterAdapter.new(self)
    end
    return nil
  end

  def update_balances
    adapter.update_balances
  end

  def fill_currencies(force = false)
    adapter.fill_currencies(force)
  end

  def changes_chart_data
    series = []
    currencies.order(:name).each do |curr|
      changes = curr.balance_changes.recent.select(:created_at, :new_balance)
      points = changes.map do |bc|
        [ bc.created_at.to_i * 1000, bc.new_balance.to_f / 10 ** 8 ]
      end
      series << {
        name: curr.name.upcase,
        data: points,
        visible: curr.name.upcase == 'BTC'
      }
    end
    series
  end

end
