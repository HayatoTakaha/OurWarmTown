class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner, foreign_key: { to_table: :users } # user_idをowner_idに変更
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end