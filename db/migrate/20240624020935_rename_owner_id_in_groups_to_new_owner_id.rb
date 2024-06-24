class RenameOwnerIdInGroupsToNewOwnerId < ActiveRecord::Migration[6.1]
  def change
    rename_column :groups, :owner_id, :new_owner_id
  end
end
