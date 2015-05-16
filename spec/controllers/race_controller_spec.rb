require 'rails_helper'

RSpec.describe RaceController, type: :controller do
	describe "POST index" do
		it "Returns a list of 'races'" do
			#Purge races
			Race.delete_all

			#Create test races
			FactoryGirl.create(:race)
			FactoryGirl.create(:race)

			get :index

			expect(assigns(:races).count).to eq(2)
		end
	end
end