class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :card,], :all
    can :create, Post
    if user
      can :manage, Post do |post|
        post.user == user
      end
    end
  end
end
