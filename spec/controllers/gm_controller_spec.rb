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
    
    describe "POST get_all_pcs" do
        it "Returns a list of all PCS" do
            #Create 2 pcs
            FactoryGirl.create(:pc)
            FactoryGirl.create(:pc)
            
            expect(Pc.count).to eq(2)
            
            post :get_all_pcs
            
            #@pcs should = 2
            expect(assigns(:pcs).count).to eq(2)
            
            #Add another
            FactoryGirl.create(:pc)
            
            post :get_all_pcs
            
            #Should now = 3
            expect(assigns(:pcs).count).to eq(3)
        end
    end
    
    describe "POST gm_modify" do
        it "Modifies a PC" do
            #Create a PC to modify
            pc = FactoryGirl.create(:pc, agility: 1, brawn: 1)
            
            #Modify 'agility' = 5
            post :modify_pc, {:format => 'json', pc:{id: pc.id, agility: 5, brawn: 5, cunning: 5, presence: 5, knowledge: 5, presence: 5}, skills:{}}
            
            expect(assigns(:pc).agility).to eq(5);
            expect(assigns(:pc).brawn).to eq(5);
        end
    end
end