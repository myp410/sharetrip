class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.references :post, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.time :start_time, null: false
      t.time :finish_time
      t.string :place 

      t.timestamps
    end
  end
end
