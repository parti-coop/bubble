class Post < ActiveRecord::Base
  paginates_per 5

  belongs_to :user
  has_many :comments
  scope :recent, -> { order(created_at: :desc) }
  validate :should_have_name
  validates :body, presence: true

  def name
    user.try(:name) || guest_name
  end

  private

  def should_have_name
    errors.add(:guest_name, "이름을 입력하세요") if user.blank? and guest_name.blank?
  end
end
