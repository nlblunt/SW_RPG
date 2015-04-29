class Pc < ActiveRecord::Base
    has_and_belongs_to_many :skills
    belongs_to :player
    
    def init
        self.skills << Skill.all
    end
end
