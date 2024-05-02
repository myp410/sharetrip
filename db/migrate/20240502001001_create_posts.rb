class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user_id, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status

      t.timestamps
    end
  end
end
