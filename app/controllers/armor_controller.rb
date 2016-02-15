class ArmorController < ApplicationController
	def index
		armors = Armor.all

		render json: armors
	end

	def create
		#Create a new armor
		a = Armor.create(armor_params)
		a.save

		if a.valid?
			render json: {msg: "Armor created"}
		else
			render status: :error, json: {e: "Error creating armor"}
		end
	end

	private
	def armor_params
		params.require(:armor).permit(:name, :defense, :soak, :description, :price, :notes)
	end

end
