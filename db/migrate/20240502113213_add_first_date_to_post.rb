class AddFirstDateToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_date, :date ,null: false
    add_column :posts, :finish_date, :date ,null: false
  end
end
