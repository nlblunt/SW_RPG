FactoryGirl.define do
  factory :pc do
    name "TestChar"
    brawn 0
    agility 0
    intellect 0
    cunning 0
    willpower 0
    presence 0
    wounds_thresh 10
    wounds_current 0
    strain_thresh 10
    strain_current 0
    critical 1
    soak 1
    status "started"
  end

end
