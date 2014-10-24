class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.string :api_key
      t.string :api_secret
      t.string :api_url
      t.timestamps
    end
  end
end
