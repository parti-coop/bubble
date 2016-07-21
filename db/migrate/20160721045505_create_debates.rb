class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :slug, null: false
      t.integer :alpha_count, default: 0
      t.integer :beta_count, default: 0
      t.timestamps null: false
    end
  end
end
