class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :slug, null: false
      t.integer :upvotes_count, default: 0
      t.timestamps null: false
    end
  end
end
