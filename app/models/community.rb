class Community < ApplicationRecord
  belongs_to :user
  has_many :links
  has_many :users, through: :links
end
