json.extract! notification, :id, :recipient_id, :actor_id, :read_at, :action, :notifiable_id, :notifiable_type, :created_at, :updated_at
json.url notification_url(notification, format: :json)
