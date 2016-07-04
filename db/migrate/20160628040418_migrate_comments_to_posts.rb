class MigrateCommentsToPosts < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      query = """
         INSERT INTO posts(board_slug, guest_name, guest_email, title, body, created_at, updated_at)
         SELECT 'bill-choice', name, email, left(body, 20), body, created_at, updated_at FROM comments
      """
      ActiveRecord::Base.connection.execute query
      say query

      Comment.destroy_all
    end
  end

  def down
    raise "unimplemented"
  end
end

