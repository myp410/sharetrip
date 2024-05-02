class AddFirstDateToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_date, :date
    add_column :posts, :finish_date, :date
  end
end
