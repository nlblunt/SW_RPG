class Pc < ActiveRecord::Base
    has_many :pcs_skills
    has_many :skills, :through => :pcs_skills
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
        self.intellect = self.race.intellect
        self.cunning = self.race.cunning
        self.willpower = self.race.willpower
        self.presence = self.race.presence
        
        #Set wounds and strain threshholds
        self.wounds_thresh = self.race.wounds_thresh + self.brawn
        self.strain_thresh = self.race.strain_thresh + self.willpower
        
        #Set wounds, critical wounds, soak, and strain to 0
        self.wounds_current = 0
        self.strain_current = 0
        self.critical       = 0
        self.soak           = self.brawn
        
        #Set initial XP and credits
        self.xp = self.race.xp
        self.credits = 500
        
        #Set the Career Skills
        self.career.skills.each do |skill|
           s = self.pcs_skills.find_by_skill_id(skill.id)
           s.cskill = true
           self.pcs_skills << s
        end
    end
end
