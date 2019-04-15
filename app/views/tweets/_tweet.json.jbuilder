json.extract! tweet, :id, :tweet_content, :user_name, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
