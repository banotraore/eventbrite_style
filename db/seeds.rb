# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Purge the user table before create 10 users to fill it
User.destroy_all
num = 1
5.times do
  fake_password = Faker::Lorem.characters(10)
  User.create(
    email:"test_thp_bt#{num}@yopmail.com",
    encrypted_password: fake_password,
    description: Faker::TvShows::GameOfThrones.quote,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  num += 1

end
