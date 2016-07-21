class Opinion < ActiveRecord::Base
  validates :body, presence: true

  scope :in_debate, ->(debate_slug) { where(debate_slug: debate_slug)}
end
