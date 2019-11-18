class Link < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  has_many :votes

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :url, presence: true
end
