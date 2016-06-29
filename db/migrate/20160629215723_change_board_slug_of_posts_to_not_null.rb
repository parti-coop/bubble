class ChangeBoardSlugOfPostsToNotNull < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        query = "UPDATE posts SET board_slug = 'party-building'"
        ActiveRecord::Base.connection.execute query
        say query
      end
      change_column_null :posts, :board_slug, false
    end
  end
end
