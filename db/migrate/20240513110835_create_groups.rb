class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :owner_id, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
