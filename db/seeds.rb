# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb または新しい Rake タスクに追加
# SQLite3の外部キー制約を無効化
Admin.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)
