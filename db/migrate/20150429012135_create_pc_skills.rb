class CreatePcSkills < ActiveRecord::Migration
  def change
    create_table :pcs_skills, id: false do |t|
      t.belongs_to :pc
      t.belongs_to :skill
    end
  end
end
