# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create!(
  [
    {email: 'olivia@example.com', first_name: 'Olivia', last_name: 'tanaka', first_name_kana: 'オリビエ', last_name_kana: 'タナカ', address: '111111', post_code: '111111', phone_number: '111111', password: 'password', admin: true},
    {email: 'ttt@example.com', first_name: 'bob', last_name: 'bob', first_name_kana: 'ボブ', last_name_kana: 'ボブ', address: '222222', post_code: '222222', phone_number: '222222', password: 'password'}
  ]
)
