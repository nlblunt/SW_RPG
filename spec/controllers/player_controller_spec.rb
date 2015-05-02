require 'rails_helper'

RSpec.describe PlayerController, type: :controller do
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
end