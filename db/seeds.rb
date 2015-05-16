# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'test@email.com', username: 'user', password: 'password', password_confirmation: 'password')
user.create_player(name: 'player')

Skill.create(name: "Astrogation", attrib: "Intellect")
Skill.create(name: "Athletics", attrib: "Brawn")
Skill.create(name: "Charm", attrib: "Presence")
Skill.create(name: "Coerce", attrib: "Willpower")
Skill.create(name: "Computers", attrib: "Intellect")
Skill.create(name: "Cool", attrib: "Presence")
Skill.create(name: "Coordination", attrib: "Agility")
Skill.create(name: "Deceit", attrib: "Cunning")
Skill.create(name: "Discipline", attrib: "Willpower")
Skill.create(name: "Knowledge", attrib: "Intellect")
Skill.create(name: "Leadership", attrib: "Presence")
Skill.create(name: "Mechanics", attrib: "Intellect")
Skill.create(name: "Medicine", attrib: "Intellect")
Skill.create(name: "Negotiation", attrib: "Presence")
Skill.create(name: "Perception", attrib: "Cunning")
Skill.create(name: "Pilot", attrib: "Agility")
Skill.create(name: "Resilience", attrib: "Brawn")
Skill.create(name: "Skulduggery", attrib: "Cunning")
Skill.create(name: "Stealth", attrib: "Agility")
Skill.create(name: "Streetwise", attrib: "Cunning")
Skill.create(name: "Survival", attrib: "Cunning")
Skill.create(name: "Vigilance", attrib: "Willpower")

Skill.create(name: "Brawl", attrib: "Brawn")
Skill.create(name: "Gunnery", attrib: "Agility")
Skill.create(name: "Melee", attrib: "Brawn")
Skill.create(name: "Ranged - Light", attrib: "Agility")
Skill.create(name: "Ranged - Heavy", attrib: "Agility")

Race.create(name: "Human", agility: 2, brawn: 2, intellect: 2, presence: 2, willpower: 2, cunning: 2)
Race.create(name: "Wookiee", agility: 1, brawn: 3, intellect: 2, presence: 2, willpower: 2, cunning: 2)

Career.create(name: "Smuggler")
