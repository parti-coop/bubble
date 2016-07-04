class DropEamilUniqIndexOfUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: [:provider, :email], unique: true
  end
end
