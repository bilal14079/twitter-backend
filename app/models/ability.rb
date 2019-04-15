class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Tweet
    can :read, User

    if user.present?
      can :manage, Tweet, user_id: user.id
      # can :manage, Comment, if Comment.user.id == user.id
      can :add_like, Tweet
      can [:follow, :unfollow, :search], User
      # can :read, Tweet, if user.is_following?(Tweet.user) || user_id: user.id  
      # can [:show], Tweet do |tweet|
      #   tweet.user_id: user.id || tweet.user_id: UserFriend.where(user_id:user.id).friend_id
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
