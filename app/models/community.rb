class Community < ApplicationRecord
  has_many :links
  has_many :users, through: :links

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
