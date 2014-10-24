class CreateTradePairs < ActiveRecord::Migration
  def change
    create_table :trade_pairs do |t|
      t.belongs_to :exchange
      t.belongs_to :currency
      t.belongs_to :market
      t.timestamps
    end
  end
end
