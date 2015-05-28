require 'rails_helper'

RSpec.describe CareerController, type: :controller do
	describe "POST index" do
		it "Returns a list of 'careers'" do
			#Purge races
			Career.delete_all

			#Create test races
			FactoryGirl.create(:career)
			FactoryGirl.create(:career)

			get :index

			expect(assigns(:careers).count).to eq(2)
		end
	end
	
	describe "GET career_specialization" do 
		it "Returns a list of associated specializations for career" do
			Career.delete_all
			Specialization.delete_all
			
			c = FactoryGirl.create(:career)
			s1 = FactoryGirl.create(:specialization)
			s2 = FactoryGirl.create(:specialization)
			s3 = FactoryGirl.create(:specialization)
			
			
			c.specializations << s1
			c.specializations << s2

			get :get_career_specializations, {id: c.id}
			
			#Total specializations should = 3
			expect((Specialization.all).count).to eq(3)
			
			#Only 2 assigned, so it should = 2
			expect(assigns(:spec).count).to eq(2)
		end
	end
	
	describe "GET all_specializations" do
		it "Returns a list of all specializations"
	end
end
