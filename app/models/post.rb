class Post < ActiveRecord::Base
  paginates_per 10

  BOARD_SLUG_BILL_CHOICE = 'bill-choice'
  BOARD_SLUG_PARTY_BUILDING = 'party-building'

  belongs_to :user
  has_many :comments

  scope :recent, -> { order(created_at: :desc) }
  scope :in_party_building_board, -> { where(board_slug: Post::BOARD_SLUG_PARTY_BUILDING) }
  scope :in_bill_choice_board, -> { where(board_slug: Post::BOARD_SLUG_BILL_CHOICE) }

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
