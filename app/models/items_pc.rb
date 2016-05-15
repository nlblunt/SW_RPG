class ItemsPc < ActiveRecord::Base
    belongs_to :item
    belongs_to :pc
end