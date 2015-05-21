class PlayerController < ApplicationController
      before_action :authenticate_user!, only: [:update, :create_pc]
  
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
    #Update User and Player information
    #params[:id, :user_params(), :player_params()]
    
    @user = User.find(params[:id])
		
		if @user.update(user_params) and @user.player.update
		  #If update was valid, render the updated info
			render json: @user.player
		else
		  #Else render status error
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
  
  def create_pc
    #Create a new PC for the player
    #params[:id, :pc_params(:name, :race_id, :career_id)]
    
    pc = Pc.create(pc_params)
    
    #Initials PC
    pc.init
    
    if pc.valid?
      #PC is valid, assign to player with passed ID
      @player = Player.find(params[:id])
      @player.pcs << pc
      
      render json: pc
    else
      #PC is invalid
      render status: :error, nothing: true
    end
  end
  
  def get_pc_skills
    #Get the PC we are needing the skills for
    @pc = Pc.find(params[:id])
    
    
    render :get_pc_skills
  end
  
  private
  
  def player_params
    params.require(:player).permit(:name)
  end
  
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
  
  def pc_params
    params.require(:pc).permit(:name, :race_id, :career_id)
  end
end
