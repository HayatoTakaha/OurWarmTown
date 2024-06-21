class RemoveDuplicateColumnsFromAdmins < ActiveRecord::Migration[6.1]
  def change
    # Ensure the columns do not exist before removing to avoid errors
    remove_column :admins, :remember_created_at if column_exists?(:admins, :remember_created_at)
    remove_column :admins, :encrypted_password if column_exists?(:admins, :encrypted_password)
    remove_column :admins, :reset_password_token if column_exists?(:admins, :reset_password_token)
  end
end
