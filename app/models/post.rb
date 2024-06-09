class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many_attached :image
  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validates :group_id, presence: true
end

