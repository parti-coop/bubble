class PartyName < ActiveRecord::Base
  def percentage
    upvotes_count == 0 ? upvotes_count : (upvotes_count * 100.0 / PartyName.all.sum(:upvotes_count))
  end
end
