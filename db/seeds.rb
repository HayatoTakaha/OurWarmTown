# SQLite3の外部キー制約を無効化
if ActiveRecord::Base.connection.adapter_name == 'SQLite'
  ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = OFF')
end

# 管理者アカウントの作成
admin_name = ENV['ADMIN_NAME']
admin_email = ENV['ADMIN_EMAIL']
admin_password = ENV['ADMIN_PASSWORD']

if Admin.find_by(email: admin_email).nil?
  Admin.create!(
    name: admin_name,
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password
  )
  puts "Admin user created with email: #{admin_email}"
else
  puts "Admin user with email: #{admin_email} already exists"
end

# SQLite3の外部キー制約を再度有効化
if ActiveRecord::Base.connection.adapter_name == 'SQLite'
  ActiveRecord::Base.connection.execute('PRAGMA foreign_keys = ON')
end
