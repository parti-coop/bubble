class AddSequentialIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sequential_id, :integer

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.transaction do
          ActiveRecord::Base.record_timestamps = false
          Post.all.each { |p|
            p.set_sequential_ids;
            p.save
          }
          ActiveRecord::Base.record_timestamps = true
        end
      end
    end
  end
end
