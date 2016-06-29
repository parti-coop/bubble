class Comment < ActiveRecord::Base
  paginates_per 10
  belongs_to :post
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }

  def title
    body[0..20].gsub('\n', ' ')
  end

  def name
    guest_name || user.name
  end
end
