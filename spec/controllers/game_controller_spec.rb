#SPEC file for GameController
#Rails 5.0 compliant
require 'rails_helper'

RSpec.describe GameController, type: :controller do
  before :each do
    Session.delete_all  
  end
  
  describe "GET get_all_sessions" do
    it "returns a list of game sessions" do
      #Create 2 game sessions
      FactoryGirl.create(:session)
      FactoryGirl.create(:session)
      
      expect(Session.count).to eq(2)
     
      get :get_all_sessions
      
      resp = JSON.parse(response.body)
      expect(resp.count).to eq(2)
    end
  end
  
  describe "POST create_session" do
    it "creates a new game session" do
      post :create_session, {session:{name: "Game Session", description: "Here we go", status: "active"}}
      
      #Session count = 1
      expect(Session.count).to eq(1)
      
      #Session name = "Game Session"
      resp = JSON.parse(response.body)
      
      expect(resp['name']).to eq("Game Session")
    end
  end
  
  describe "POST restore_session" do
    it "restores a previous session" do
      g_session = FactoryGirl.create(:session)
      
      post :restore_session, {id: g_session.id}
      
      #Resp = g_session
      resp = JSON.parse(response.body)
      
      expect(resp['id']).to eq(g_session.id)
    end
  end
end