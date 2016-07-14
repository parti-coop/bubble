class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :post, nil: false, index: true
      t.references :user, nil: false, index: true
      t.timestamps nil: false
    end

    add_index :upvotes, [:post_id, :user_id], unique: true
  end
end
