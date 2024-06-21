class AddDeviseAttributesToAdmins < ActiveRecord::Migration[6.1]
  def change
    change_table :admins, bulk: true do |t|
      t.string :email, null: false, default: "" unless column_exists?(:admins, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:admins, :encrypted_password)

      t.string   :reset_password_token unless column_exists?(:admins, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:admins, :reset_password_sent_at)
      t.datetime :remember_created_at unless column_exists?(:admins, :remember_created_at)

      t.index :email, unique: true unless index_exists?(:admins, :email)
      t.index :reset_password_token, unique: true unless index_exists?(:admins, :reset_password_token)
    end
  end
end
