class AddUsernameToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :username, :string
  end
end
