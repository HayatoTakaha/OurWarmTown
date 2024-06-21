class Admin < ApplicationRecord
  # Deviseの設定を削除して、has_secure_passwordを使用します
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
