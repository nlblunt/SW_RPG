class WeaponController < ApplicationController
	def index
		@weapons = Weapon.all

		render :index
	end

	def create
		#Create a new weapon
		w = Weapon.create(weapon_params)
		w.skill_id = Skill.find_by_name(params[:skill]).id
		w.save

		if w.valid?
			render json: {msg: "Weapon created"}
		else
			render status: :error, json: {e: "Error creating weapon"}
		end
	end

    def show
        #Get individual weapon
        w = Weapon.find_by_id(params[:id])
        
        render json: w
    end
    
    def update
        #Update the weapon
        w = Weapon.find_by_id(params[:id])
        w.update(weapon_params)
        
        render json: {msg: "Weapon Updated"}
    end
    
    def destroy
        #Delete weapon
        w = Weapon.find_by_id(params[:id])
        w.delete
        
        render json: {msg: "Weapon Deleted"}
    end
    
	private
	def weapon_params
		params.require(:weapon).permit(:name, :damage, :critical, :range, :price, :special, :notes)
	end
end
