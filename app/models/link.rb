class Link < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  has_many :votes
  belongs_to :community

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :url, presence: true

  scope :hottest, -> { order(hot_score: :desc) }
  scope :newest, -> { order(created_at: :desc) }

  def community_attributes=(attr)
    binding.pry
    self.community = Community.find_or_create_by(attr)
  end

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end

  def calc_hot_score
    points = upvotes - downvotes
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = hot_score(points, time_ago_in_hours)
  
    update_attributes(points: points, hot_score: score)
  end
  
  private
  
  def hot_score(points, time_ago_in_hours, gravity = 1.8)
    (points - 1) / (time_ago_in_hours + 2) ** gravity
  end

end
