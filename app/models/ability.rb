class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    alias_action :update, :destroy, to: :update_destroy
      if user.member?
        can :update, User, id: user.id
        can :create, Post
        can :update_destroy, Post
        can :edit, Post
        can [:read, :create], Comment
        can :update_destroy, Comment, user_id: user.id
        can :read, :all
      else
        can :read, :all
    end
  end
end
