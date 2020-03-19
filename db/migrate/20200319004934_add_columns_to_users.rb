class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website, :string, default: ''
    add_column :users, :profile, :text, default: ''
    add_column :users, :phone, :string, default: ''
    add_column :users, :sex, :string, default: ''
  end
end
