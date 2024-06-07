class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :admin_level, null: false
      t.timestamps
    end
  end
end