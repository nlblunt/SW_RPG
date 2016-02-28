class Weapon < ActiveRecord::Base
    belongs_to :skill
    has_and_belongs_to_many :pcs
end
