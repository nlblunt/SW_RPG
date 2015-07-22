require 'rails_helper'

RSpec.describe GameController, type: :controller do
  describe "GET index" do
    it "returns a list of game sessions" do
      #Create 2 game sessions
      FactoryGirl.create(:session)
      FactoryGirl.create(:session)
      
      expect(Session.count).to eq(2)
     
      get :index
      
      expect(assigns(:sessions).count).to eq(2)
    end
  end
end