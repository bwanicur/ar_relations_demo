class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false # PG will not allow null values for name
      t.timestamps
    end
    add_index :tasks, :name, unique: true
  end
end
