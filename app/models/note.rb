class Note < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :body

  belongs_to :user
  has_many :likes, dependent: :destroy
end
