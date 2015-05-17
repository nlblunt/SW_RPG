class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      
      t.timestamps null: false
    end
    
    create_table :careers_skills, id: false do |t|
      t.belongs_to :career
      t.belongs_to :skill
    end
    
    create_table :careers_pcs, id: false do |t|
      t.belongs_to :career
      t.belongs_to :pc
    end
  end
end
