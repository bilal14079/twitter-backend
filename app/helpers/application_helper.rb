module ApplicationHelper

    def is_following? user_id
        Relationship.find_by(followed_id: user_id, follower_id: current_user.id).present?
    end

    def unread_notifications_count
        Notification.where(recipient: current_user, read_at: nil).count
    end
end
