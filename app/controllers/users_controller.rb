class UsersController < ApplicationController
  load_and_authorize_resource

  def follow
    current_user.following << @user
    redirect_to @user
  end

  # Unfollows a user.
  def unfollow
    user = Relationship.find_by(followed_id: params[:id]).followed
    current_user.following.delete(user)
    redirect_to user
  end

  def search
    @users=  User.where("name LIKE '%#{params[:name]}%'")
  end

  def show
    @tweets = @user.tweets.includes([:user, {comments: :user}])
  end

  def notifications
    @notifications = Notification.where(recipient: current_user).unread
    @notifications = @notifications.includes(:actor, :recipient, :notifiable) #includes is for eager loading
  end

  private
end
