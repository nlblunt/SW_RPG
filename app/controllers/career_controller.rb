class CareerController < ApplicationController
  def index
    @careers = Career.all
    
    render json: @careers
  end
  
  def get_career_specializations
    @spec = Specialization.where(career_id: params[:id])

    render json: @spec
  end
end
