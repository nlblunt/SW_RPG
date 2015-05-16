require 'rails_helper'

RSpec.describe PlayerController, type: :controller do
    before :each do
       User.delete_all
       Player.delete_all
       Pc.delete_all
    end
    
    describe "POST Create" do
       it "With Valid Params creates a new User and Player" do
          post :create, {user:{email: "test@test.com", username: "user", password: "password", password_confirmation: "password"},player:{name: "Nicolas"}}
          
          expect(User.count).to eq(1)
          expect(Player.count).to eq(1)
       end
    end
    
    describe "POST player_check" do
       it "Returns 'Forbidden' when not signed in" do
           post :player_check
           
           expect(response.status).to eq(403)
        end
        
        it "Returns 'OK' when signed in" do
           @user = User.create(email: "test@test.com", username: "user", password: "password", password_confirmation: "password")
           sign_in @user
           
           post :player_check
           
           expect(response.status).to eq(200)
        end
    end
    
    describe "POST create_pc" do
      describe "User Signed In" do
       it "Creates a PC and assigns to player" do
          #Create a player
          player = FactoryGirl.create(:player)
          race = FactoryGirl.create(:race)
          career = FactoryGirl.create(:career)
          @user = User.create(email: "test@test.com", username: "user", password: "password", password_confirmation: "password")
          sign_in @user
          
          post :create_pc, {id: player.id, pc:{name: "Test", race_id: race.id, career_id: career.id}}
          
          expect(Pc.count).to eq(1)
          
          expect(player.pcs.count).to eq(1)
          
          #Test for return status
          expect(response.status).to eq(200)
       end
     end
     describe "User NOT Signed In" do
        it "Does NOT create a PC and assign it to a player" do
          #Create a player
          player = FactoryGirl.create(:player)
          race = FactoryGirl.create(:race)
          career = FactoryGirl.create(:career)
          
          post :create_pc, {id: player.id, pc:{name: "Test", race_id: race.id, career_id: career.id}}
          
          expect(Pc.count).to eq(0)
          
          expect(player.pcs.count).to eq(0)
          
          #Test for return status
          expect(response.status).to eq(302)
        end
     end
    end
end