class PlayerController < ApplicationController
  def index
  end

  def create
		user = User.create(user_params)
		player = user.create_player(player_params)
		
		if player.valid?
			render :nothing => true, :status => :created
		else
			render :nothing => true, :status => :error
		end
  end
  
  def update
    @user = User.find(params[:id])
		
		if @user.update(user_params) and @user.player.update(player_params)
			render json: @user.player
		else
			render status: :error, nothing: true
		end  
  end
  
  def player_check
    if user_signed_in?
      render status: :ok, json: current_user.player
    else
      render status: :forbidden, nothing: true
    end
  end
  
  def create_pc(player_id)
    #Create a new PC for the player
    #pc = Pc.create(pc_params)
    pc = Pc.create
    
    #Initials PC
    pc.init
    
    #Assign PC to PLAYER
    Player.first.pcs << pc
  end
  
  private
  
  def player_params
    params.require(:player).permit(:name)
  end
  
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
  
  def pc_params
    params.require(:pc).permit(:name, :species_id, :career_id)
  end
end
