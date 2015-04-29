# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'test@email.com', username: 'user', password: 'password', password_confirmation: 'password')
user.create_player(name: 'player')

Skill.create(name: "Brawl", attrib: "Strength")
Skill.create(name: "Pilot", attrib: "Agility")
