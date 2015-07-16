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
  
  def modify_pc
    pc = Pc.find_by_id(params[:pc][:id])
    
    pc.gm_modify(params[:pc])
    
    #Save the updated skills into the PC
    pc.skills << params[:skills]
    render nothing: true
  end
end
