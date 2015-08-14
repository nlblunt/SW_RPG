class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.integer  :xp
      t.integer  :brawn
      t.integer  :agility
      t.integer  :intellect
      t.integer  :cunning
      t.integer  :willpower
      t.integer  :presence
      t.integer  :wounds_thresh
      t.integer  :strain_thresh
      t.string   :bonus
      t.text     :description 
      t.string   :avatar
      
      t.timestamps null: false
    end
  end
end
