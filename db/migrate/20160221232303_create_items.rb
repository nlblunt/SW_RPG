class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.text :notes

      t.timestamps null: false
    end
	  
	  create_table :items_pcs, id: false do |t|
		  t.belongs_to :item
      	  t.belongs_to :pc
    end
  end
end
