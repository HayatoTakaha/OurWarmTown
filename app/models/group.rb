class Group < ApplicationRecord
  # Associations
  belongs_to :owner, class_name: 'User', foreign_key: 'new_owner_id', optional: false
  has_one_attached :image
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :posts, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
