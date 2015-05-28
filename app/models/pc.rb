class Pc < ActiveRecord::Base
    has_many :pcs_skills
    has_many :skills, :through => :pcs_skills
    belongs_to :player
    belongs_to :race
    belongs_to :career
    has_and_belongs_to_many :specializations
    
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
            #Set career skills from career
           self.set_career_skill(skill.id)
           
           #s = self.pcs_skills.find_by_skill_id(skill.id)
           #s.cskill = true
           #self.pcs_skills << s
        end
        
        #Set the bonus rank from race
        if self.race.bonus == "Specialization"
            #TODO: Add human specialization selection here
        else
           skill_id = Skill.find_by_name(self.race.bonus)
           
           #Increase the rank by 1
           self.increase_skill_rank(skill_id.id, 'false')
        end
        
        #Set the status to 'started'
        self.status = "started"
    end
    
    def increase_skill_rank(skill_id, use_xp)
        #Increases the rank of the skill by 1.  If use_xp = false, no change to xp, else calculate cost and subtract
        
        if use_xp == 'false'
            #Find the skill in the pcs_skills table by skill_id
            pc_skill = self.pcs_skills.find_by_skill_id(skill_id)
            
            #Increase the rank
            pc_skill.rank = pc_skill.rank + 1
            
            #Save back into skill table
            self.pcs_skills << pc_skill
            
            return "Success"
        else
           #TODO: Add rank and use XP 
        end
    end
    
    def set_career_skill(skill_id)
        #Sets the skill as a career skill
        
        #Find the skill in the pcs_skills table by skill_id
        pc_skill = self.pcs_skills.find_by_skill_id(skill_id)
        
        #Set cskill = true
        pc_skill.cskill = true
        
        #Save back into skill table
        self.pcs_skills << pc_skill
    end
    
    def get_career_skills
        #Returns a list of career skills only
        
       return self.pcs_skills.where(cskill: true) 
    end
    
    def set_specialization(spec_id, use_xp)
        spec = Specialization.find_by_id(spec_id)
        
        if use_xp == "false"
            #Use no XP
            self.specializations << spec
            return "Specialization Added Successfully"
        else
            #Use XP
            #Test for enough XP
            if self.xp >= 10
                #There is enough XP
                self.specializations << spec
                self.xp = self.xp - 10
                return "Specialization Added Successfully"
            else
                #Not enough XP
                return "Insufficient XP"
            end
        end
    end
end
