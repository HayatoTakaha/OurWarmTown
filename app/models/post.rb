class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validate :group_presence_if_id_present

  private

  def group_presence_if_id_present
    if group_id.present? && group.nil?
      errors.add(:group, "must exist")
    end
  end
end
