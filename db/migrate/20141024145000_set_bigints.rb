class SetBigints < ActiveRecord::Migration
  def change
    change_column :currencies, :balance, :integer, limit: 8
    change_column :balance_changes, :old_balance, :integer, limit: 8
    change_column :balance_changes, :new_balance, :integer, limit: 8
  end
end
