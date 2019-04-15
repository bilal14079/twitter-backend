
class HomeController < ApplicationController

  def index
    if current_user.present?
      followed_ids = Relationship.where(follower_id: current_user.id).select("followed_id AS id")
      @tweets = Tweet.where(user_id: current_user.id).or(Tweet.where(user_id: followed_ids))
      @tweets = @tweets.includes([:user, {comments: :user}])
      @tweets =@tweets.paginate(page: params[:page], per_page: 3)
    end
  end

  
end
