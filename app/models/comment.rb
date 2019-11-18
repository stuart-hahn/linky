class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :body, presence: true

  scope :newest, -> { order(created_at: :desc) }
end
