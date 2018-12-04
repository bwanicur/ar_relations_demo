class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :profile_id # this supports our has_one relationship
      t.string :email, null: false # PG will not allow null for email
      t.string :full_name
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
