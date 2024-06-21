class RemoveIndexFromAdminsEmail < ActiveRecord::Migration[6.1]
  def change
    remove_index :admins, :email if index_exists?(:admins, :email)
  end
end
