class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :guest_name
      t.string :guest_email
      t.string :title, null: false
      t.text :body
      t.timestamps null: false
    end
  end
end
