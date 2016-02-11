json.array! @weapons do |w|
	json.name	w.name
	json.skill	Skill.find_by_id(w.skill_id).name
	json.damage w.damage
	json.critical w.critical
	json.range	w.range
	json.price	w.price
	json.special w.special
end