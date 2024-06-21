class AddDeviseToAdmins < ActiveRecord::Migration[6.1]
  def change
    change_table :admins, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    add_index :admins, :reset_password_token, unique: true
  end
end
