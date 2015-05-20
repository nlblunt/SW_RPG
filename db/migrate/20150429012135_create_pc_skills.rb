class CreatePcSkills < ActiveRecord::Migration
  def change
    create_table :pcs_skills do |t|
      t.belongs_to :pc
      t.belongs_to :skill
      t.integer    :rank, :default => 0
      t.boolean    :cskill, :default => false
    end
  end
end
