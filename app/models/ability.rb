class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :card,], :all
    can :create, [Post, Comment, Opinion]
    can [:upvote, :unvote], Post
    if user
      can :manage, [Post, Comment] do |model|
        model.user == user
      end
      if user.admin?
        can [:stick, :unstick], Post
      end
    end
  end
end
