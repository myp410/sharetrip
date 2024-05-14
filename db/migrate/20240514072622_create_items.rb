class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :post, index: true, foreign_key: true
      t.string :name ,null: false
      t.boolean :have ,default: false

      t.timestamps
    end
  end
end
