class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :exchange
      t.belongs_to :currency
      t.belongs_to :market
      t.boolean :sell, default: false
      t.integer :amount, limit: 8
      t.integer :rate, limit: 8
      t.integer :remain, limit: 8
      t.integer :fee, limit: 8
      t.string :internal_id
      t.timestamp :closed_at
      t.boolean :closed, default: false
      t.timestamps
    end

    add_index :orders, :exchange_id
    add_index :orders, :currency_id
    add_index :orders, :market_id
    add_index :orders, :internal_id
    add_index :orders, :closed
  end
end
