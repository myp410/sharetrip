class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.references :post, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.datetime :start_time, null: false
      t.datetime :finish_time
      t.string :place 
      t.integer :what_day, null: false

      t.timestamps
    end
  end
end
