class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.references :post, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.datetime :start_time, null: false
      t.datetime :finish_time
      t.string :place ,null: false, default: ""
      t.float :latitude, null: false, default: 0
      t.float :longitude, null: false, default: 0
      t.integer :what_day, null: false
      t.integer :traffic_method,null: false , default: 0
      t.integer :traffic_time_hour
      t.integer :traffic_time_min

      t.timestamps
    end
  end
end
