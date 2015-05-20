FactoryGirl.define do
  factory :race do
    name "TestRace"
    brawn 2
    agility 2
    intellect 2
    cunning 2
    willpower 2
    presence 2
    
    wounds_thresh 10
    strain_thresh 10
    xp 100
    bonus "Brawl"
  end

end
