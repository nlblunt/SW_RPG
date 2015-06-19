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
    
    describe "GET get_player_pcs" do
        it "returns a list of PCs for the player" do
            player = FactoryGirl.create(:player)
            #Initial check: Player should have 0 PCs
            expect(player.pcs.count).to eq(0)
            
            #Assign a PC to player.  Count should = 1
            player.pcs << FactoryGirl.create(:pc)
            expect(player.pcs.count).to eq(1)
            
            #Test
            get :get_player_pcs, {id: player.id}
            expect(assigns(:pcs).count).to eq(1)
            
            #Add another
            player.pcs << FactoryGirl.create(:pc)
            expect(player.pcs.count).to eq(2)
            
            get :get_player_pcs, {id: player.id}
            expect(assigns(:pcs).count).to eq(2)
        end
    end
    
    describe "POST create_pc" do
      describe "User Signed In" do
       it "Creates a PC and assigns to player" do
          #Create a player
          @user = User.create(email: "test@test.com", username: "user", password: "password", password_confirmation: "password")
          sign_in @user
          player = FactoryGirl.create(:player)
          race = FactoryGirl.create(:race)
          career = FactoryGirl.create(:career)
          FactoryGirl.create(:skill)
          
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
    
    describe "POST set_specialization" do
        it "Should not exceed 3 specializations per PC" do
            pc1 = FactoryGirl.create(:pc)

            #Set initial 3 specialization.  Everything else should fail.
            pc1.specializations << FactoryGirl.create(:specialization)
            pc1.specializations << FactoryGirl.create(:specialization)
            pc1.specializations << FactoryGirl.create(:specialization)
            spec = FactoryGirl.create(:specialization)
            
            post :set_specialization, {id: pc1.id, spec_id: spec.id, use_xp: "false"}
            
            expect(pc1.specializations.count).to eq(3)
            
            resp = JSON.parse(response.body)
            expect(resp["msg"]).to eq("Error: Exceeds maximum specializations")
        end
        
        describe "Using XP" do
            describe "With sufficient XP" do
                it "Should add a specialization and use XP" do
                    pc2 = FactoryGirl.create(:pc, xp: 10)
                    #pc2.xp = 10
                    spec = FactoryGirl.create(:specialization)
                   
                    post :set_specialization, {id: pc2.id, spec_id: spec.id, use_xp: "true"}
                   
                    #Specializations should = 1
                    expect(pc2.specializations.count).to eq(1)
                   
                    #XP should change
                    expect(assigns(:pc).xp).to eq(5)
                end
            end
            
            describe "Without sufficient XP" do
                it "Should not add a specialization" do
                    pc = FactoryGirl.create(:pc, xp: 2)
                    
                    spec = FactoryGirl.create(:specialization)
                   
                    post :set_specialization, {id: pc.id, spec_id: spec.id, use_xp: "true"}
                   
                    #Specializations should = 0
                    expect(pc.specializations.count).to eq(0)
                   
                    #XP should not change
                    expect(assigns(:pc).xp).to eq(2)   
                    
                    resp = JSON.parse(response.body)
                    expect(resp["msg"]).to eq("Insufficient XP")
                end
            end
        end
        
        describe "Not using XP" do
            it "Should add a specialization without XP" do
               #Create a PC and set XP to 10 for testing
               pc = FactoryGirl.create(:pc, xp: 10)
               
               spec = FactoryGirl.create(:specialization)
               
               post :set_specialization, {id: pc.id, spec_id: spec.id, use_xp: "false"}
               
               #Specializations should = 1
               expect(pc.specializations.count).to eq(1)
               
               #XP should not change
               expect(assigns(:pc).xp).to eq(10)
            end
        end
    end
    
    describe "GET get_pc" do
        it "returns the pc" do
            pc = FactoryGirl.create(:pc)
            
            get :get_pc, {id: pc.id}
            
            expect(assigns(:pc).id).to eq(1)
        end
    end
    
    describe "POST set_pc_status" do
        it "sets the PC status" do
           pc = FactoryGirl.create(:pc)
           
           #Intial status should = "started"
           expect(pc.status).to eq("started")
           
           #Set status = "active"
           post :set_pc_status, {id: pc.id, status: "active"}
           
           expect(assigns(:pc).status).to eq("active")
        end
    end
    
    describe "GET get_pc_xp" do
        it "Returns the XP" do
            pc = FactoryGirl.create(:pc, xp: 100)
            
            get :get_pc_xp, {id: pc.id}
            
            expect(pc.xp).to eq(100)
            expect(assigns(:xp)).to eq(100)
        end
    end
    
    describe "GET pc_skills" do
        it "Returns a list of pc skills" 
    end
    
    describe "GET get_career_skills" do
        it "Returns a list of career skills"
    end
    
    describe "POST increase_skill_rank" do
        describe "Using XP" do
            it "Increase skill rank using XP"
        end
        
        describe "Not using XP" do
            it "Increase skill rank without using XP"
        end 
    end
    
    describe "POST increase_attribute" do
        it "Increases attribute using XP" do
            pc = FactoryGirl.create(:pc, brawn: 1, cunning: 2, agility: 3, xp: 50)
            
            post :increase_attribute, {id: pc.id, attribute: "brawn"}
            #Brawn should be 2 now
            expect(assigns(:pc).brawn).to eq(2)
            
            post :increase_attribute, {id: pc.id, attribute: "cunning"}
            #Cunning should be 3 now
            expect(assigns(:pc).cunning).to eq(3)
            
            post :increase_attribute, {id: pc.id, attribute: "agility"}
            #Not enough XP, so agility should = 3 still
            expect(assigns(:pc).agility).to eq(3)
            
            resp = JSON.parse(response.body)

            expect(resp["msg"]).to eq("Insufficient XP")
            
        end
    end
end