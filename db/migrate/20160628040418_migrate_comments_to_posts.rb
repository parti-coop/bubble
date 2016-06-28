class MigrateCommentsToPosts < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      Comment.all.each do |comment|
        Post.create(board_slug: 'bill-choice', guest_name: comment.name, guest_email: comment.email, title: comment.title, body: comment.body, created_at: comment.created_at, updated_at: comment.updated_at)
      end

      Comment.destroy_all
    end
  end

  def down
    raise "unimplemented"
  end
end

