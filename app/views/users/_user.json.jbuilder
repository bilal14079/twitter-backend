json.extract! user, :id, :name, :email, :password, :user_name, :reset_password_token, :friends_count, :tweets_count, :created_at, :updated_at
json.url user_url(user, format: :json)
