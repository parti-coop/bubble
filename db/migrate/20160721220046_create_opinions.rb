class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.string :name, null: false
      t.text :body
      t.string :debate_slug, null: false
      t.timestamps null: false
    end
  end
end
