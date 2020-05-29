class User < ApplicationRecord
  has_secure_password
  has_many :posts
  
  validates :name, {presence: true}
  validates :instaid, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  
  def posted
    return Post.where(user_id: self.id)
  end
  
  def posts
    return Post.where(post_id: self.id)
  end
  
  
  
  def posts_average
    self.posts.average(:rate).round
  end
end
