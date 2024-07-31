class User < ApplicationRecord
  validates :name, presence: true
  has_one_attached :profile_image
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :owned_groups, class_name: 'Group', foreign_key: 'new_owner_id', dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Check if the user has liked a specific post
  def like(post)
    self.likes.find_or_create_by(post_id: post.id)
  end

  def unlike(post)
    self.likes.find_by(post_id: post.id)&.destroy
  end

  def liked?(post)
    likes.exists?(post_id: post.id)
  end
end
