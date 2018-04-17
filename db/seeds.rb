# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

5.times do
    User.create!(
        username: Faker::LordOfTheRings.unique.character, 
        password: "password", 
        email: Faker::Internet.unique.free_email
    )
end

users = User.all

10.times do
    List.create!(
        name: Faker::Movie.quote, 
        private: false, 
        user: users.sample
    )
end

lists = List.all

15.times do
    Item.create!(
        name: Faker::Simpsons.quote, 
        complete: false, 
        list: lists.sample
    )
end

puts "#{User.all.count} Users Added"
puts "#{List.all.count} Lists Added"
puts "#{Item.all.count} Items Added"