class Opinion < ActiveRecord::Base
  validates :body, presence: true
  validates :choice, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :in_debate, ->(debate_slug) { where(debate_slug: debate_slug)}
end
