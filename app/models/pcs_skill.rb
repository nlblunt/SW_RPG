class PcsSkill < ActiveRecord::Base
    #NO LONGER NEEDED
    belongs_to :skill
    belongs_to :pc
end
