class AddRateToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :rate, :integer, limit: 8
  end
end
