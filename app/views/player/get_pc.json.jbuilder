json.id   @pc.id
json.name @pc.name
json.xp @pc.xp
json.credits @pc.credits
json.brawn @pc.brawn
json.agility @pc.agility
json.intellect @pc.intellect
json.cunning @pc.cunning
json.willpower @pc.willpower
json.presence @pc.presence
json.wounds_thresh @pc.wounds_thresh
json.wounds_current @pc.wounds_current
json.strain_thresh @pc.strain_thresh
json.strain_current @pc.strain_current
json.critical @pc.critical
json.soak @pc.soak
json.player_id @pc.player_id
json.race_id @pc.race_id
json.race_name @pc.race.name
json.career_id @pc.career_id
json.career_name @pc.career.name
json.avatar @pc.avatar
json.status @pc.status

json.weapons @pc.weapons do |w|
	json.name	w.name
	json.skill	Skill.find_by_id(w.skill_id).name
	json.damage w.damage
	json.critical w.critical
	json.range	w.range
	json.price	w.price
	json.special w.special
    json.notes w.notes
end

json.armors @pc.armors do |a|
    json.name a.name
    json.description a.description
    json.defense a.defense
    json.soak a.soak
    json.price a.price
    json.notes a.notes
end

json.specialization @pc.specializations