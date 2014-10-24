class AddIndexesToCurrencies < ActiveRecord::Migration
  def change
    add_index :currencies, :name
    add_index :currencies, :exchange_id
    add_index :currencies, :deposit_address
  end
end
