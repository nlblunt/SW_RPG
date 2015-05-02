require 'rails_helper'

RSpec.describe Pc, type: :model do
  describe "INIT" do
     it "Initializes a new PlayerCharacter" do
         #Initalize working models
         pc = FactoryGirl.create(:pc)
         race = FactoryGirl.create(:race)
         career = FactoryGirl.create(:career)
         FactoryGirl.create(:skill)
         
         #Initalize new PC with race.id and career.id
         pc.init(race.id, career.id)
         
         #Tests
         expect(pc.race_id).to eq(race.id)
         expect(pc.career.id).to eq(career.id)
         
         expect(pc.brawn).to eq(race.brawn)
         expect(pc.agility).to eq(race.agility)
         expect(pc.intelect).to eq(race.intelect)
         expect(pc.cunning).to eq(race.cunning)
         expect(pc.willpower).to eq(race.willpower)
         expect(pc.presence).to eq(race.presence)
         
         expect(pc.skills.count).to eq(1)
     end
  end
end
