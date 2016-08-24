class Proposition < ActiveRecord::Base
  has_many :comments, as: :commentable

  scope :order_by_importance,  -> { order(importance: :desc) }

  def self.by_slug(slug)
    find_by(slug: slug)
  end

  def self.most_important
    order_by_importance.first
  end
end
