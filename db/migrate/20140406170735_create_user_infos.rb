class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :name
      t.references :user, index: true
      
      t.timestamps
    end
    
  end
end
