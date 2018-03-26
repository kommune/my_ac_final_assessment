class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  has_many :notes, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :passive_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy

  has_many :followings, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
  
end
