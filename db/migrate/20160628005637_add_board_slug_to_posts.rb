class AddBoardSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :board_slug, :string

    reversible do |dir|
      dir.up do
        query = "UPDATE posts SET board_slug = 'party-building'"
        ActiveRecord::Base.connection.execute query
        say query
      end
      change_column_null :posts, :board_slug, true
    end
  end
end
