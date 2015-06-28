class GmController < ApplicationController
  def index
  end
  
  def gm_check
    if gm_signed_in?
      render status: :ok, nothing: true
    else
      render status: :forbidden, nothing: true
    end
  end
end
