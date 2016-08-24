class AddCommetableToComments < ActiveRecord::Migration
  def up
    add_reference :comments, :commentable, polymorphic: true, index: true

    query = "UPDATE comments SET commentable_id = post_id, commentable_type = 'Post'"
    ActiveRecord::Base.connection.execute query
    say query

    change_column_null :comments, :commentable_id, false
    change_column_null :comments, :commentable_type, false

    remove_column :comments, :post_id
  end

  def down
    raise "unimplemented"
  end
end
