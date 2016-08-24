class Comment < ActiveRecord::Base
  paginates_per 10
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }
  scope :earlier, -> { order(created_at: :asc) }
  validate :should_have_name
  validates :body, presence: true

  def title
    body[0..20].gsub('\n', ' ')
  end

  def name
    guest_name || user.try(:name)
  end

  private

  def should_have_name
    errors.add(:guest_name, "이름을 입력하세요") if user.blank? and guest_name.blank?
  end
end
