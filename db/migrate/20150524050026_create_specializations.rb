class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :name
      t.text   :descriptin

      t.belongs_to :career
      t.timestamps null: false
    end
    
    create_table :skills_specializations, id: false do |t|
      t.belongs_to :skill
      t.belongs_to :specialization
    end
    
    create_table :pcs_specializations, id: false do |t|
      t.belongs_to :pc
      t.belongs_to :specialization
    end
    
  end
end
