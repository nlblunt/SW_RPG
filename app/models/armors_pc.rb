class ArmorsPc < ActiveRecord::Base
    belongs_to :armor
    belongs_to :pc
end