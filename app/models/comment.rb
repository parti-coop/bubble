class Comment < ActiveRecord::Base
  paginates_per 10
  scope :recent, -> { order(created_at: :desc) }
end
