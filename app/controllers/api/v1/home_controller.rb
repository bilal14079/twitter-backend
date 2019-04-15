
class Api::V1::HomeController < Api::V1::ApplicationController
  respond_to :json
  
  def index
    followed_ids = Relationship.where(follower_id: @current_user.id).select("followed_id AS id")
    tweets = Tweet.where(user_id: @current_user.id).or(Tweet.where(user_id: followed_ids))
    tweets = tweets.includes([:user, {comments: :user}])
    if tweets.any?
      render json: {tweets: tweets.as_json(include: [:user, :comments], methods: :cover_picture_url)}
    else
      render status: 401, json: { error: 'No tweets found' } 
    end
  end
end
