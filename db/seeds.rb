# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Purge the user table before create 10 users to fill it
User.destroy_all
num = 20
10.times do
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

#Pour ne choisir au hasard 1 admin que parmis les users creer

Event.destroy_all
3.times do
  date_parse = (Faker::Time.between(Date.today, 1.year.from_now)).strftime "%Y-%m-%d %H:%M:%S"
  Event.create(
    start_date: date_parse,
    duration:rand(5..150),
    title: Faker::JapaneseMedia::OnePiece.quote,
    description: Faker::TvShows::Community.quotes,
    price: rand(1..100),
    location: Faker::Address.city,
    admin: User.all.sample
  )
end

Attendance.destroy_all
7.times do
  Attendance.create(
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id,
  )
end
