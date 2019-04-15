module LikesHelper

    def already_liked? tweet
        tweet.likes.find_by(user: current_user).present?
    end
end
