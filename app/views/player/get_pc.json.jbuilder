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

json.skills @pc.skills

json.skills @pc.pcs_skills do |s|
    json.id   s.skill.id
    json.name s.skill.name
    json.attrib s.skill.attrib
    json.rank s.rank
    json.career s.cskill
end
    
json.weapons @pc.pcs_weapons do |w|
    json.id     w.id
	json.name	w.weapon.name
	json.skill	Skill.find_by_id(w.weapon.skill_id).name
	json.damage w.weapon.damage
	json.critical w.weapon.critical
	json.range	w.weapon.range
	json.price	w.weapon.price
	json.special w.weapon.special
    json.notes w.weapon.notes
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