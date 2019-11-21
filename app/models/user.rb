class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :links, dependent: :destroy
  has_many :comments
  has_many :communities, through: :links
  has_many :commented_links, through: :comments, source: :link
  has_many :votes

  def owns_link?(link)
    self == link.user
  end

  def owns_community?(community)
    self == community.user
  end

  def upvote(link)
    votes.create(upvote: 1, link: link)
  end

  def upvoted?(link)
    votes.exists?(upvote: 1, link: link)
  end
  
  def remove_vote(link)
    votes.find_by(link: link).destroy
  end

  def downvote(link)
    votes.create(downvote: 1, link: link)
  end
  
  def downvoted?(link)
    votes.exists?(downvote: 1, link: link)
  end
  
  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
