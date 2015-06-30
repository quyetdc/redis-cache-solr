# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#  Category
#   name: string
#   desc: string

categories_arr = [
    {
        name: 'Web Development',
        desc: 'Any thing you need to know about how to develop a website'
    },

    {
        name: 'Mobile development',
        desc: 'Any thing you need to know about how to develop a mobile application'
    }
]

categories_arr.each do |obj|
  Category.create(name: obj[:name], desc: obj[:desc])
end

# User
#   email
#   password
#   password_confirmation

users_arr = [
    {
        email: 'user_1@test.com',
        password: 'password',
        password_confirmation: 'password',
    },

    {
        email: 'user_2@test.com',
        password: 'password',
        password_confirmation: 'password',
    }
]

users_arr.each do |obj|
  User.create(email: obj[:email], password: obj[:password], password_confirmation: obj[:password])
end

