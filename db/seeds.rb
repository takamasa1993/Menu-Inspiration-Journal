# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 初期ジャンルの作成
Genre.create(name: '主菜')
Genre.create(name: '副菜')
Genre.create(name: 'デザート')
Genre.create(name: 'スープ')
Genre.create(name: 'その他')

# 管理者アカウントの作成
unless Admin.find_by(email: 'admin@example.com')
  Admin.create!(
    email: 'admin@example.com',
    password: 'securepassword',
    password_confirmation: 'securepassword'
  )
end