class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.integer :send_count
    end
  end
end
