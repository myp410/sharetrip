class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :itinerary, index: true, foreign_key: true
      t.string :title, null: false
      t.text :link ,null: false

      t.timestamps
    end
  end
end
