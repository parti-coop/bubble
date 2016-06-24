class Post < ActiveRecord::Base
  paginates_per 5

  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }

  def name
    user.try(:name) || guest_name
  end
end
