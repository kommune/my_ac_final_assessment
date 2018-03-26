class Relationship < ApplicationRecord

  validates :following, presence: true
  validates :follower, presence: true
  
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
end
