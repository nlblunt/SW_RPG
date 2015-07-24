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
    #Modify PC.  Only non-breaking attritubes can be changed
    @pc = Pc.find_by_id(params[:pc][:id])
    
    @pc.gm_modify(params[:pc], params[:skills])
    
    #Save the updated skills into the PC

    render nothing: true
  end
  
  def pc_modify_strain
    #Modify PC strain.  Can be + or -
    @pc = Pc.find_by_id(params[:id])

    @pc.modify_strain(params[:amount])
    
    render nothing: true
  end
  
  def get_session_pcs
    #Returns a list of PCs in the current game session
    
    #Get the session we are needing
    g_session = Session.find_by_id(params[:id])
    
    #Get all PCs for g_session
    @pcs = g_session.pcs
    
    render json: @pcs
  end
  
  def add_session_pcs
    #Adds a PC to the game session
    
  end
end
