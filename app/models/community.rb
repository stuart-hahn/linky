class Community < ApplicationRecord
  belongs_to :user
  has_many :links
  has_many :users, through: :links

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
