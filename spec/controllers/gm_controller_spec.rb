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
    
    describe "POST pc_modify_strain" do
       it "Modifies a PC strain" do
          #Create a PC to modify
          pc = FactoryGirl.create(:pc)
          expect(pc.strain_current).to eq(0)
          
          #Modify the PC strain.  Accepts ID and Modify amount. Incremental
          post :pc_modify_strain, {id: pc.id, amount: 1}
          
          expect(assigns(:pc).strain_current).to eq(1)
          
          #Repeat to ensure proper incremental
          post :pc_modify_strain, {id: pc.id, amount: 1}
          expect(assigns(:pc).strain_current).to eq(2)
          
          #Now a negative (healing) amount
          post :pc_modify_strain, {id: pc.id, amount: -1}
          expect(assigns(:pc).strain_current).to eq(1)
          
          #Make sure strain can't go negative
          post :pc_modify_strain, {id: pc.id, amount: -100}
          expect(assigns(:pc).strain_current).to eq(0)
          
          #Make sure strain can't go higher than max
          post :pc_modify_strain, {id: pc.id, amount: 100}
          expect(assigns(:pc).strain_current).to eq(pc.strain_thresh)
       end
    end
    
    describe "POST get_session_pcs" do
       it "Returns a list of PCs for game session" do
           #Create 2 PC and add to game :session
           pc1 = FactoryGirl.create(:pc)
           pc2 = FactoryGirl.create(:pc)
           
           #Create a game session
           g_session = FactoryGirl.create(:session)
           
           expect(g_session.pcs.count).to eq(0)
           
           #Add PCs to g_session
           g_session.pcs << pc1
           g_session.pcs << pc2
           
           expect(g_session.pcs.count).to eq(2)
           
           post :get_session_pcs, {id: g_session.id}
           
           #@pcs should = 2
           expect(assigns(:pcs).count).to eq(2)
       end
    end
  
  describe "GET add_session_pcs" do
    it "Adds a pc to the session" do
      #Create a session and a PC
      g_session = FactoryGirl.create(:session)
      pc = FactoryGirl.create(:pc)
      
      #Add the PC to the session
      post :add_session_pcs, {s_id: g_session.id, pc_id: pc.id}
      
      #Response status = 200
      expect(response.status).to eq(200)
      
      #JSON Response should = 1 PC
      resp = JSON.parse(response.body)
      expect(resp.count).to eq(1)
    end
  end
end