require 'rails_helper'

RSpec.describe GameController, type: :controller do
  before :each do
    Session.delete_all  
  end
  
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
  
  describe "POST create" do
    it "creates a new game session" do
      post :create_session, {session:{name: "Game Session", description: "Here we go", status: "active"}}
      
      expect(Session.count).to eq(1)
    end
  end
end