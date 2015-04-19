class PlayerController < ApplicationController
  def index
  end

  def create
  	Player.create(name: 'player')
  end
end
