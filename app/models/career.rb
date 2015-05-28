class Career < ActiveRecord::Base
    belongs_to :pc
    has_and_belongs_to_many :skills
    has_many :specializations
end
