class AddBtcBalanceToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :btc_balance, :integer, limit: 8
  end
end
