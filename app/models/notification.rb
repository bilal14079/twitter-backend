class Notification < ApplicationRecord
    belongs_to :recipient, class_name: 'User'
    belongs_to :actor, class_name: 'User'
    belongs_to :notifiable, polymorphic: true

    scope :unread, -> { where(read_at: nil) }

    def tweet_id
        notifiable.tweet_id
    end
end
