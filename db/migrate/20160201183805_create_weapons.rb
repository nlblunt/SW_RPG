class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.references :skill
      t.integer :damage
      t.integer :critical
      t.string :range
      t.integer :price
      t.string :special
      t.text :description
      t.text :notes
      
      t.timestamps null: false
    end

    create_table :pcs_weapons do |t|
      t.belongs_to :pc
      t.belongs_to :weapon
    end
  end
end
