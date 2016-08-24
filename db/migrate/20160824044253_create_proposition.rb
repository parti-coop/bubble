class CreateProposition < ActiveRecord::Migration
  def change
    create_table :propositions do |t|
      t.string :title, null: false
      t.string :proponent, null: false
      t.string :slug, null: false, index: true, unique: true
      t.text :body
      t.timestamps null: false
    end
  end
end
