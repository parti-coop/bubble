class Post < ActiveRecord::Base
  paginates_per 20
  acts_as_sequenced scope: :board_slug

  BOARD_SLUG_BILL_CHOICE = 'bill-choice'
  BOARD_SLUG_PARTY_BUILDING = 'party-building'
  BOARD_SLUG_PARTY_SUGGEST = 'party-suggest'

  BOARD_NAME_BILL_CHOICE = '법안 정하기'
  BOARD_NAME_PARTY_BUILDING = '정당 만들기'
  BOARD_NAME_PARTY_SUGGEST = '정당활동 제안하기'

  BOARDS = {
    Post::BOARD_SLUG_BILL_CHOICE => Post::BOARD_NAME_BILL_CHOICE,
    Post::BOARD_SLUG_PARTY_BUILDING => Post::BOARD_NAME_PARTY_BUILDING,
    Post::BOARD_SLUG_PARTY_SUGGEST => Post::BOARD_NAME_PARTY_SUGGEST
  }
  belongs_to :user
  has_many :comments

  scope :recent, -> { order(created_at: :desc) }
  scope :in_party_building_board, -> { where(board_slug: Post::BOARD_SLUG_PARTY_BUILDING) }
  scope :in_bill_choice_board, -> { where(board_slug: Post::BOARD_SLUG_BILL_CHOICE) }
  scope :in_board, ->(board_slug) { where(board_slug: board_slug) }

  validate :should_have_name
  validates :body, presence: true

  def name
    user.try(:name) || guest_name
  end

  def bill_choice_board?
    board_slug == Post::BOARD_SLUG_BILL_CHOICE
  end

  def title
    bill_choice_board? ? body.try(:truncate, 20) : self[:title]
  end

  private

  def should_have_name
    errors.add(:guest_name, "이름을 입력하세요") if user.blank? and guest_name.blank?
  end
end
