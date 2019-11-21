class Community < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :users, through: :links

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  scope :alphabetized, -> { order(:title)}
  scope :most_links, -> {left_joins(:links).group('communities.id').order('count(links.community_id) desc')}

end
