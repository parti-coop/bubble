class Ability
  include CanCan::Ability

  def initialize(user)
    can [:read, :card,], :all
    can :create, [Post, Comment]
    if user
      can :manage, [Post, Comment] do |model|
        model.user == user
      end
    end
  end
end
