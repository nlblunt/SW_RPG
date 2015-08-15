json.array! @pcs do |pc|
    json.id   pc.id
    json.name pc.name
    json.xp pc.xp
    json.credits pc.credits
    json.brawn pc.brawn
    json.agility pc.agility
    json.intellect pc.intellect
    json.cunning pc.cunning
    json.willpower pc.willpower
    json.presence pc.presence
    json.wounds_thresh pc.wounds_thresh
    json.wounds_current pc.wounds_current
    json.strain_thresh pc.strain_thresh
    json.strain_current pc.strain_current
    json.critical pc.critical
    json.soak pc.soak
    json.player_id pc.player_id
    json.race_id pc.race_id
    json.race_name pc.race.name
    json.career_id pc.career_id
    json.career_name pc.career.name
    json.avatar pc.avatar
    json.status pc.status
    
    json.specialization pc.specializations
end