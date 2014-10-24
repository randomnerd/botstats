class AddAdapterToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :api_adapter, :string
  end
end
