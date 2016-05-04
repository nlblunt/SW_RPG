class Weapon < ActiveRecord::Base
    belongs_to :skill
    has_many :pcs_weapons
    has_many :pcs, :through => :pcs_weapons
end
