class AddDepositAddressToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :deposit_address, :string
  end
end
