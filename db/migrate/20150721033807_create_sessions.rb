class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :description
      t.string :status

      t.timestamps null: false
    end
    
    create_table :pcs_sessions do |t|
      t.belongs_to :pcs
      t.belongs_to :sessions
    end
  end
end
