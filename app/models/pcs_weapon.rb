class PcsWeapon < ActiveRecord::Base
    belongs_to :weapon
    belongs_to :pc
end
