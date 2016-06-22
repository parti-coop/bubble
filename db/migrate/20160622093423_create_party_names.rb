class CreatePartyNames < ActiveRecord::Migration
  def change
    create_table :party_names do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.integer :upvotes_count, default: 0
      t.timestamps null: false
    end
  end
end
