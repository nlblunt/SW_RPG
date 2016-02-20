class Skill < ActiveRecord::Base
    has_many :pcs_skills
    has_many :pcs, :through => :pcs_skills
    has_and_belongs_to_many :career
    has_and_belongs_to_many :specialization

    has_many :weapons
end
