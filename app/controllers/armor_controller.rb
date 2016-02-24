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
			render status: :error, json: {e: "Error Creating Armor"}
		end
	end

    def destroy
        #Delete the armor
        a = Armor.find_by_id(params[:id])
        a.delete
        
        render json: {msg: "Armor Deleted"}
    end
    
	private
	def armor_params
		params.require(:armor).permit(:name, :defense, :soak, :description, :price, :notes)
	end

end
