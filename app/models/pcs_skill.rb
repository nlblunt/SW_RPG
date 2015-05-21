class PcsSkill < ActiveRecord::Base
    belongs_to :skill
    belongs_to :pc
end
