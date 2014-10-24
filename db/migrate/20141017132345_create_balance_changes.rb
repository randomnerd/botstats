class CreateBalanceChanges < ActiveRecord::Migration
  def change
    create_table :balance_changes do |t|
      t.belongs_to :currency
      t.integer :old_balance
      t.integer :new_balance
      t.timestamp :created_at
    end

    add_index :balance_changes, :currency_id
  end
end
