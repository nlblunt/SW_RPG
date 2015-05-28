class Specialization < ActiveRecord::Base
    belongs_to :career
    has_and_belongs_to_many :skills
    has_and_belongs_to_many :pcs
end
