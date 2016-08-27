class Post < ActiveRecord::Base
  paginates_per 10
  acts_as_sequenced scope: :board_slug

  BOARD_SLUG_BILL_CHOICE = 'bill-choice'
  BOARD_SLUG_PARTY_BUILDING = 'party-building'
  BOARD_SLUG_PARTY_SUGGEST = 'party-suggest'

  BOARD_NAME_BILL_CHOICE = '법안 정하기'
  BOARD_NAME_PARTY_BUILDING = '정당 만들기'
  BOARD_NAME_PARTY_SUGGEST = '정당활동 제안'

  BOARDS = {
    Post::BOARD_SLUG_BILL_CHOICE => Post::BOARD_NAME_BILL_CHOICE,
    Post::BOARD_SLUG_PARTY_BUILDING => Post::BOARD_NAME_PARTY_BUILDING,
    Post::BOARD_SLUG_PARTY_SUGGEST => Post::BOARD_NAME_PARTY_SUGGEST
  }
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :upvotes

  scope :recent, -> { order(created_at: :desc) }
  scope :hottest, -> { order(upvotes_count: :desc) }
  scope :in_party_building_board, -> { where(board_slug: Post::BOARD_SLUG_PARTY_BUILDING) }
  scope :in_bill_choice_board, -> { where(board_slug: Post::BOARD_SLUG_BILL_CHOICE) }
  scope :in_board, ->(board_slug) { where(board_slug: board_slug) }
  scoped_search on: [:title, :body]

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

  def upvote(user)
    upvotes.build(user: user) unless upvotes.exists?(user: user)
  end

  def upvoted_by?(user)
    upvotes.exists?(user: user)
  end

  def self.best(board_slug, limit)
    if board_slug == 'all'
      where('upvotes_count > 3').order(upvotes_count: :desc).limit(limit)
    else
      where(board_slug: board_slug).where('upvotes_count > 3').order(upvotes_count: :desc).limit(limit)
    end
  end

  def self.stickies(board_slug)
    if board_slug == 'all'
      where(sticky: true).recent
    else
      where(board_slug: board_slug).where(sticky: true).recent
    end
  end

  private

  def should_have_name
    errors.add(:guest_name, "이름을 입력하세요") if user.blank? and guest_name.blank?
  end
end
