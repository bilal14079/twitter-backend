class Api::V1::UsersController < Api::V1::ApplicationController
  respond_to :json

  def follow
    user = User.find_by(id: params[:id])
    if user.present?
      @current_user.following << user
      render status: 200, json: { msg: "user added to current_user following list"}
    else
      render status: 400, json: { msg: 'Invalid User ID supplied' }
    end
  end

  # Unfollows a user.
  def unfollow
    user = Relationship.find_by(followed_id: params[:id]).followed
    if user.present?
      @current_user.following.delete(user)
      render status: 200, json: { msg: "user get unfollowed"}
    else
      render status: 400, json: { msg: 'Invalid User ID supplied' }
    end
    
  end

  def search
    users=  User.where("name ILIKE '%#{params[:search_value]}%'")
    if users.any?
      render status: 200, json: { users: users.as_json }
    else
      render status: 400, json: {error: "No such User Found"}
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user.present?
      tweets = user.tweets.includes([:user, {comments: :user}])
      render json: {tweets: tweets.as_json(include: [:user, :comments], methods: :cover_picture_url), 
              user: {id: user.id, name: user.name, user_name: user.user_name, email: user.email, following: user.following.count, followers: user.followers.count },
              current_user_following_list: @current_user.following }
    else
      render status: 400, json: {error: 'No Such User Exists'}
    end
  end

  def notifications
    notifications = Notification.where(recipient: @current_user).unread
    notifications = notifications.includes(:actor, :recipient, :notifiable)
    if notifications.any?
      render status: 200, json: { notifications: notifications.as_json(methods: :tweet_id)}
    else
      render status: 400, json: {notifications: [], message: 'No unread notification found' } 
    end
  end

  private
end
