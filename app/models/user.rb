class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :tweets, dependent: :destroy
  has_many :user_friends
  has_many :tweet_likes
  has_many :likes
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  validates :name,  presence: true
  validates :user_name,  presence: true, uniqueness: true
  
  acts_as_commontator

  def self.create_from_provider_data(provider_data)
    last_user_id = last.id + 1
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = "user " + last_user_id.to_s
      user.user_name = "user-" + last_user_id.to_s 
      # user.skip_confirmation!
    end
  end

end
