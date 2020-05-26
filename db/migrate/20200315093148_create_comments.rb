class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, foreign_key: true, null: false
      t.references :micropost, foreign_key: true, null: false

      t.timestamps
  
      t.index [:user_id, :micropost_id]
    end
  end
end
