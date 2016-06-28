class AddPostIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :post, index: true, null: false
  end
end
