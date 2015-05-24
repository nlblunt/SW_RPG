require 'rails_helper'

RSpec.describe Pc, type: :model do
  describe "INIT" do
     it "Initializes a new PlayerCharacter" do
         #Initalize working models
         pc = FactoryGirl.create(:pc)
         race = FactoryGirl.create(:race)
         career = FactoryGirl.create(:career)
         FactoryGirl.create(:skill)
         
         #Set race & class manually ONLY for testing
         pc.race_id = race.id
         pc.career_id = career.id
         
         #Initalize new PC with race.id and career.id
         pc.init
         
         #Test race and career assignment
         expect(pc.race_id).to eq(race.id)
         expect(pc.career.id).to eq(career.id)
         
         #Test attribute assignments
         expect(pc.brawn).to eq(race.brawn)
         expect(pc.agility).to eq(race.agility)
         expect(pc.intellect).to eq(race.intellect)
         expect(pc.cunning).to eq(race.cunning)
         expect(pc.willpower).to eq(race.willpower)
         expect(pc.presence).to eq(race.presence)
         
         #Test skill counts
         expect(pc.skills.count).to eq(1)
         
         #Test wounds and strain assignment
         expect(pc.wounds_thresh).to eq(pc.brawn + race.wounds_thresh)
         expect(pc.strain_thresh).to eq(pc.willpower + race.strain_thresh)
         
         #Test XP
         expect(pc.xp).to eq(race.xp)
         
         #Test Credits
         expect(pc.credits).to eq(500)
         
         #Test bonus skill
         s_id = Skill.find_by_name(pc.race.bonus)
         expect(pc.pcs_skills.find_by_skill_id(s_id.id).rank).to eq(1)
     end
  end
end
