class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.integer :user_id, null: false
      t.text :content
      t.timestamps
    end
    add_index :emails, :user_id
  end
end
