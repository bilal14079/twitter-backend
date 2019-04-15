class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_many :tweet_likes
  has_many :likes
  has_many :comments, dependent: :destroy
  has_one_attached :cover_picture

  validates :tweet_title,  presence: true
  validates :tweet_content,  presence: true

  def cover_picture_url
    'http://localhost:3000' + rails_blob_path(cover_picture) if cover_picture.attachment
  end

  def tweet_likes_count
    likes.count
  end

end
