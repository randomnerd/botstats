class AddEnableUpdatesFlagToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :enable_updates, :boolean
  end
end
