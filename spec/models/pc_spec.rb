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
  
  describe  "increase_skill_rank" do
      describe "Use XP"do
          it "Increases skill rank with XP"
      end
      
      describe "Does Not Use XP" do
          it "Increases skill rank without XP"
      end
  end
  
  describe "increase_attribute" do
    it "increases the attribute" do
       #Create a pc with varied attributes.  
       #All attribure increases use XP
       pc = FactoryGirl.create(:pc, brawn: 1, agility: 2, cunning: 3, xp: 100)
       
       pc.increase_attribute("brawn")
       #Brawn should = 2, xp = 100 - 20 = 80
       expect(pc.brawn).to eq(2)
       expect(pc.xp).to eq(80)
       
       pc.increase_attribute("agility")
       #Agility should = 3, xp = 80 - 30 = 50
       expect(pc.agility).to eq(3)
       expect(pc.xp).to eq(50)
       
       pc.increase_attribute("cunning")
       #Cunning should = 4, xp = 50 - 40 = 10
       expect(pc.cunning).to eq(4)
       expect(pc.xp).to eq(10)
       
       #Not enough xp, so no increase and xp remains the same
       resp = pc.increase_attribute("cunning")
       expect(pc.cunning).to eq(4)
       expect(pc.xp).to eq(10)
       expect(resp[:msg]).to eq("Insufficient XP")
    end
  end
  
  describe "set_career_skill" do
      it "Sets a skill as a career skill"
  end
  
  describe "get_career_skills" do
      it "Returns a list of career skills" do
         pc = FactoryGirl.create(:pc)
         sk1 = FactoryGirl.create(:skill)
         sk2 = FactoryGirl.create(:skill)
         
         pc.skills << sk1
         pc.skills << sk2
         
         pc.set_career_skill(sk1.id)
         
         career_skills = pc.get_career_skills
         
         #Test career_skiils
         expect(career_skills.count).to eq(1)
         expect(career_skills.first.skill.name).to eq(sk1.name)
      end
  end
  
  describe "set_specialization" do
      describe "Use XP" do
         it "assigns a specialization and uses XP" do
         pc = FactoryGirl.create(:pc, xp: 0)
         race = FactoryGirl.create(:race)
         
         spec = FactoryGirl.create(:specialization)
         
         pc.race_id = race.id
         
         #If XP < 10
         #pc.xp = 0
         resp = pc.set_specialization(spec.id, true)
         expect(pc.specializations.count).to eq(0)
         expect(pc.xp).to eq(0)
         expect(resp[:msg]).to eq("Insufficient XP")
         
         #If XP > 5
         pc2 = FactoryGirl.create(:pc, xp: 5)
         resp = pc2.set_specialization(spec.id, "true")
         expect(pc2.specializations.count).to eq(1)
         expect(pc2.xp).to eq(0)   
         expect(resp[:msg]).to eq("Specialization Added Successfully")
        end
    end
      
      describe "Do Not Use XP" do
        it "assigns a specialization without using XP" do
             pc = FactoryGirl.create(:pc, xp: 100)
             race = FactoryGirl.create(:race)

             spec = FactoryGirl.create(:specialization)
             pc.xp = 100
             pc.race_id = race.id
             
             resp = pc.set_specialization(spec.id, "false")
             
             expect(pc.specializations.count).to eq(1)
             expect(pc.xp).to eq(race.xp)
             expect(resp[:msg]).to eq("Specialization Added Successfully")
        end
      end
      
      it "adds the specialization skills as Career Skills" do
          pc = FactoryGirl.create(:pc, xp: 100)
          race = FactoryGirl.create(:race)
          career = FactoryGirl.create(:career)
          sp1 = FactoryGirl.create(:skill)
          sp2 = FactoryGirl.create(:skill)
          
          career.skills << sp1
          career.skills << sp2
          
          pc.race_id = race.id
          pc.career_id = career.id
          
          pc.init
          
          spec = FactoryGirl.create(:specialization)
          
          #Assign 2 skills to specialization
          spec.skills << sp1
          spec.skills << sp2

          #Assign spec to pc
          pc.set_specialization(spec.id, false)
          
          #PC should now have the 2 spec skills as class skills
          expect(pc.pcs_skills.where(cskill: true).count).to eq(2)
      end
  end
end
