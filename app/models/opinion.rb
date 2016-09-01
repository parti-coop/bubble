class Opinion < ActiveRecord::Base
  paginates_per 5
  validates :body, presence: true
  validates :choice, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :in_debate, ->(debate) { where(debate_slug: (debate.respond_to?(:slug) ? debate.slug : slug))}

  def debate
    Debate.find_by slug: debate_slug
  end
end
