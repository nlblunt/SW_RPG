class GameController < ApplicationController
  #GameController controls aspects of the game, such as game session.
  def get_all_sessions
    @sessions = Session.all
    
    render json: @sessions
  end
  
  def create_session
    g_session = Session.create(session_params)
    
    render json: g_session
  end
  
  def restore_session
    g_session = Session.find_by_id(params[:id])
    
    render json: g_session
  end
    
  private
  
  def session_params
    params.require(:session).permit(:name, :description, :status)
  end
end
