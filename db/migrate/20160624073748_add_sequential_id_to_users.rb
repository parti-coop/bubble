class AddSequentialIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sequential_id, :integer, unique: true

    reversible do |dir|
      dir.up do
        User.order(id: :asc).each do |user|
          user.set_sequential_ids
          user.save
        end
      end
    end
  end
end
