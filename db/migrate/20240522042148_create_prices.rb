class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :itinerary, index: true, foreign_key: true
      t.integer :price,null: false
      t.string :body

      t.timestamps
    end
  end
end
