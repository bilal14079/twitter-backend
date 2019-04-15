module NotificationsHelper

    def actor actor_id
        User.find_by(id: actor_id)
    end
    
    def commented_tweet comment_id
        comment = Comment.find_by(id: comment_id)
        if comment.present?
            comment.tweet_id
        end
    

    end
end
