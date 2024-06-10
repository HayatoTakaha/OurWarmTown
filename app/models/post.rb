class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many_attached :images

  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validate :group_presence, if: -> { group_id.present? }

  private

  def group_presence
    errors.add(:group, "must exist") if group.nil?
  end
end
