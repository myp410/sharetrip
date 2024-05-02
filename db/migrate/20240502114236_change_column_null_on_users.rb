class ChangeColumnNullOnUsers < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :posts, :user_ids
    remove_index :posts, :user_id_id
    remove_column :posts, :user_id_id, :integer
    change_column_null :users, :name, false
    change_column_null :users, :is_active, false
    change_column_null :posts, :title, false
    change_column_null :posts, :status, false
    change_column_default(:posts, :status, from: nil, to: "0")
    change_column_null :posts, :start_date, false
    change_column_null :posts, :finish_date, false
  end
end
