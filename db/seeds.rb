# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Admin",
             email: "admin@ullapp.org",
             password:              "Adminlog",
             password_confirmation: "Adminlog",
             usertype: "administrator",
             loclat: +19.765432,
             loclong: -80.765432,
             color: "blue",
             commcount: 25)

49.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@ullapp.org"
  password = "password"
  usertype = "buyer"
  loclat = +19.765432
  loclong = -80.765432
  color = "blue"
  commcount = 0
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               usertype: usertype,
               loclat: loclat,
               loclong: loclong,
               color: color,
               commcount: commcount)
end