require 'rails_helper'

RSpec.describe CareerController, type: :controller do
	describe "POST index" do
		it "Returns a list of 'races'" do
			#Purge races
			Career.delete_all

			#Create test races
			FactoryGirl.create(:career)
			FactoryGirl.create(:career)

			get :index

			expect(assigns(:careers).count).to eq(2)
		end
	end
end
