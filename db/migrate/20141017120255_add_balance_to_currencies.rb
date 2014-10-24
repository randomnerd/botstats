class AddBalanceToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :balance, :integer
  end
end
