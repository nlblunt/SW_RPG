require 'rails_helper'

RSpec.describe GmController, type: :controller do
    before :each do
       Gm.delete_all
    end
    
    describe "POST gm_check" do
       it "Returns 'Forbidden' when not signed in" do
           post :gm_check
           
           expect(response.status).to eq(403)
        end
        
        it "Returns 'OK' when signed in" do
           @gm = Gm.create(email: "test@test.com", password: "password", password_confirmation: "password")
           sign_in @gm
           
           post :gm_check
           
           expect(response.status).to eq(200)
        end
    end
end