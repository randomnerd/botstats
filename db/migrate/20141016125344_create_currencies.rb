class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.belongs_to :exchange
      t.string :name
      t.timestamps
    end
  end
end
