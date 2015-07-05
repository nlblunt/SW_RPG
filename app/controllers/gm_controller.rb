class GmController < ApplicationController
  def index
  end
  
  def gm_check
    #Check to see if the GM is signed in
    if gm_signed_in?
      render status: :ok, nothing: true
    else
      render status: :forbidden, nothing: true
    end
  end
  
  def get_all_pcs
    #Returns a list of all PCS
    
    @pcs = Pc.all
    
    #Render list as json
    respond_to do |format|
      format.json {render :get_all_pcs}
      format.html {render nothing: true}
    end
  end
end
