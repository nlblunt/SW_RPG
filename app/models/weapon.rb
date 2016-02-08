class Weapon < ActiveRecord::Base
	has_one :skill
	has_and_belongs_to_many :pcs
end
