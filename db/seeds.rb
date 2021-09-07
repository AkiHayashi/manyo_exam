# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  user_name:  "ユーザー１",
  email: "user@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: false)

User.create!(
  user_name:  "管理者",
  email: "admin@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)