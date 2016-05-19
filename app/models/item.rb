class Item < ActiveRecord::Base
    has_many :items_pcs
    has_many :pcs, :through => :items_pcs
    #has_and_belongs_to_many :pcs
end
