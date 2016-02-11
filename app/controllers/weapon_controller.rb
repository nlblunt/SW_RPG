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

	private
	def weapon_params
		params.require(:weapon).permit(:name, :damage, :critical, :range, :price, :special, :notes)
	end
end
