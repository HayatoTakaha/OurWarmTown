class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.string :keywords
      t.timestamps
    end
  end
end
