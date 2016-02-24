class Pc < ActiveRecord::Base
    has_many :pcs_skills
    has_many :skills, :through => :pcs_skills
    belongs_to :player
    belongs_to :race
    belongs_to :career
    has_and_belongs_to_many :specializations
    has_and_belongs_to_many :sessions
    
    has_and_belongs_to_many :weapons
    has_and_belongs_to_many :armors
    has_and_belongs_to_many :items
    
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
        if self.race.bonus == 'Specialty' or self.race.bonus == 'None'
            #TODO: Add human specialization selection here
        else
           skill_id = Skill.find_by_name(self.race.bonus)
           
           #Increase the rank by 1
           self.increase_skill_rank(skill_id.id, false)
        end
        
        #Set the avatar to the default from the Race
        self.avatar = self.race.avatar
        
        #Set the status to 'started'
        self.status = "started"
        
        self.save
    end
    
    def increase_skill_rank(skill_id, use_xp)
        #Increases the rank of the skill by 1.  If use_xp = false, no change to xp, else calculate cost and subtract
        
        if use_xp == false
            #Find the skill in the pcs_skills table by skill_id
            pc_skill = self.pcs_skills.find_by_skill_id(skill_id)
            
            #Increase the rank
            pc_skill.rank = pc_skill.rank + 1
            
            #Save back into skill table
            self.pcs_skills << pc_skill
            
            return "Success"
        else
           pc_skill = self.pcs_skills.find_by_skill_id(skill_id)
           
           if pc_skill.cskill == true
              #This is a career skill
                logger.debug("Career")
              #Check for enough xp
              if self.xp >= (pc_skill.rank + 1) * 5
                 #There is enough xp
                 pc_skill.rank = pc_skill.rank + 1
                 self.pcs_skills << pc_skill
                 
                 self.xp = self.xp - ((pc_skill.rank) * 5)
                 self.save
                 
                 return {msg: "Rank increased"}
              else
                  return {msg: "Insufficient XP to add rank"}
              end
           else
               #This is not a career skill
               logger.debug("Not Career")
               #Check for enough xp
                if self.xp >= ((pc_skill.rank + 1) * 5) + 5
                     #There is enough xp
                     pc_skill.rank = pc_skill.rank + 1
                     self.pcs_skills << pc_skill
                     
                     self.xp = self.xp - (((pc_skill.rank) * 5) + 5)
                     self.save
                     
                     return {msg: "Rank increased"}
                else
                      return {msg: "Insufficient XP to add rank"}
                end 
           end
        end
    end
    
    def increase_attribute(attribute)
        #XP cost is (next level * 10)
        #Which attribute?
        case attribute
        when "brawn"
            if self.xp >= (self.brawn + 1) * 10
                self.brawn = self.brawn + 1
                self.xp = self.xp - (self.brawn * 10)
            else
                return {msg: "Insufficient XP"}
            end
        when "agility"
            if self.xp >= (self.agility + 1) * 10
                self.agility = self.agility + 1
                self.xp = self.xp - (self.agility * 10)
            else
                return {msg: "Insufficient XP"}    
            end
        when "cunning"
            if self.xp >= (self.cunning + 1) * 10
                self.cunning = self.cunning + 1
                self.xp = self.xp - (self.cunning * 10)
            else
                return {msg: "Insufficient XP"}
            end
        when "intellect"
            if self.xp >= (self.intellect + 1) * 10
                self.intellect = self.intellect + 1
                self.xp = self.xp - (self.intellect * 10)
            else
                return {msg: "Insufficient XP"}
            end
        when "willpower"
            if self.xp >= (self.willpower + 1) * 10
                self.willpower = self.willpower + 1
                self.xp = self.xp - (self.willpower * 10)
            else
                return {msg: "Insufficient XP"}
            end
        when "presence"
            if self.xp >= (self.presence + 1) * 10
                self.presence = self.presence + 1
                self.xp = self.xp - (self.presence * 10)
            else
                return {msg: "Insufficient XP"}
            end
        end
        self.save
        
        return {msg: "Attribute increased"}
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
        
        if self.specializations.count == 3
            return {status: 200, msg: "Error: Exceeds maximum specializations"}
        end
        
        if use_xp == "false"
            #Use no XP
            self.specializations << spec

            #Need to add the specializaion skills as career skills
            spec.skills.each do |s|
                self.set_career_skill(s.id)    
            end
            
            return {status: 200, msg: "Specialization Added Successfully"}
        else
            #Use XP
            #Test for enough XP
            if self.xp >= 5
                #There is enough XP
                self.specializations << spec
                self.xp = self.xp - 5
                
                #Need to add the specilization skills as career skills
                spec.skills.each do |s|
                    self.set_career_skill(s.id)
                end
                
                return {status: 200, msg: "Specialization Added Successfully"}
            else
                #Not enough XP
                return {status: 500, msg: "Insufficient XP"}
            end
        end
    end
    
    def set_status(new_status)
       self.status = new_status
       
       self.save
    end
    
    def gm_modify(mods, skills)
      #Only modify attributes that 'CAN' be changed without major impact
        self.name = mods[:name]
        self.xp = mods[:xp]
        self.credits = mods[:credits]

        self.wounds_current = mods[:wounds_current]
        self.strain_current = mods[:strain_current]

        self.brawn = mods[:brawn]
        self.agility = mods[:agility]
        self.intellect = mods[:intellect]
        self.cunning = mods[:cunning]
        self.willpower = mods[:willpower]
        self.presence = mods[:presence]
        
        skills.each do |s|
            #Find the skill in the pcs_skills table by skill_id
            pc_skill = self.pcs_skills.find_by_skill_id(s[:id])
            
            #Adjust skill rank
            pc_skill.rank = s[:rank]
            
            #Save back into skill table
            self.pcs_skills << pc_skill
        end
        self.save
    end
    
    def modify_strain(amount)
        #Adjust strain
        self.strain_current = self.strain_current + amount.to_i
        
        #Can't go negative
        if self.strain_current < 0
            self.strain_current = 0
        end
        
        #Or higher than the thresh
        if self.strain_current > self.strain_thresh
            self.strain_current = self.strain_thresh
        end
        
        self.save
    end

    def modify_wounds(amount)
        #Adjust wounds
        self.wounds_current = self.wounds_current + amount.to_i

        #Can't go negative
        if self.wounds_current < 0
            self.wounds_current = 0
        end

        #Or higher than the thresh
        if self.wounds_current > self.wounds_thresh
            self.wounds_current = self.wounds_thresh
        end

        self.save
    end
end
