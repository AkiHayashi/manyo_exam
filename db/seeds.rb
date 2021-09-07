# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  name = "user#{i + 1}"
  email = Faker::Internet.email

  User.create(
    user_name: name,
    email: email,
    password:  "11111111",
    password_confirmation: "11111111",
  )
end

User.create!(
  user_name:  "管理者",
  email: "admin@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)

10.times do
  task = Task.create!(
    title: Faker::Dessert.variety,
    description: Faker::Books::Lovecraft.sentence,
    expired_at: DateTime.now,
    progress: "未着手",
    priority: "高",
    user_id: 1
  )
end

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end