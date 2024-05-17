class AddIsActiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_active, :boolean, default: true,null: false
    add_column :users, :introduction, :text
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
