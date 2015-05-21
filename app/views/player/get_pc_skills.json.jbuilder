json.array! @pc.pcs_skills do |s|
    json.id   s.skill.id
    json.name s.skill.name
    json.attrib s.skill.attrib
    json.rank s.rank
    json.career s.cskill
end