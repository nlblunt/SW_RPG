class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.integer  :brawn
      t.integer  :agility
      t.integer  :intelect
      t.integer  :cunning
      t.integer  :willpower
      t.integer  :presence
      t.integer  :wounds_thresh
      t.integer  :strain_thresh
      t.integer  :soak
      
      t.timestamps null: false
    end
  end
end
