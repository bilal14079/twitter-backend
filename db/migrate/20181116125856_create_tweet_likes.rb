class CreateTweetLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_likes do |t|
      t.integer :tweet_id
      t.integer :liked_by_user

      t.timestamps
    end
  end
end
