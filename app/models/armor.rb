class Armor < ActiveRecord::Base
	has_many :armors_pcs
    has_many :pcs, :through => :armors_pcs
    #has_and_belongs_to_many :pcs
end
