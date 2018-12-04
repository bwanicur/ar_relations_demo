class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.string :nickname 
      t.timestamps
    end
  end
end
