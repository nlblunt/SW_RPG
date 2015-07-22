class GameController < ApplicationController
  def index
    @sessions = Session.all
    
    render json: @sessions
  end
end
