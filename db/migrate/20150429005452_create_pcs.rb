class CreatePcs < ActiveRecord::Migration
  def change
    create_table :pcs do |t|
      t.string :name
      t.integer :brawn
      t.integer :agility
      t.integer :intellect
      t.integer :cunning
      t.integer :willpower
      t.integer :presence
      t.integer :wounds_thresh
      t.integer :wounds_current
      t.integer :strain_thresh
      t.integer :strain_current
      t.integer :critical
      t.integer :soak

      t.belongs_to :player
      t.belongs_to :race, index: true

      t.belongs_to :career, index: true
      t.timestamps null: false
    end
  end
end
