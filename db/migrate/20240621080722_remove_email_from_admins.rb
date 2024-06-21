class RemoveEmailFromAdmins < ActiveRecord::Migration[6.1]
  def change
    remove_column :admins, :email, :string if column_exists?(:admins, :email)
  end
end
