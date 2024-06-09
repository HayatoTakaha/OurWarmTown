class User < ApplicationRecord
  has_one_attached :profile_image
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id', dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :posts, dependent: :destroy
end
