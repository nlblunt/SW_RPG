class Pc < ActiveRecord::Base
    has_and_belongs_to_many :skills
    belongs_to :player
    belongs_to :race
    belongs_to :career
    
    #Initialize the new PC
    #Setup skill table
    #Sets attributres based on race
    def init
        #Initialize skill table
        self.skills << Skill.all
        
        #Set Attributes from Race
        self.brawn = self.race.brawn
        self.agility = self.race.agility
        self.intelect = self.race.intelect
        self.cunning = self.race.cunning
        self.willpower = self.race.willpower
        self.presence = self.race.presence
    end
end
