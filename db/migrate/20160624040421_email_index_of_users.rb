class EmailIndexOfUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: :email, unique: true
    add_index :users, [:provider, :email], unique: true
  end
end
