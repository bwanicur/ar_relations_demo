class CreateUserTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tasks do |t|
      t.integer :user_id, null: false # option same as { null: false } - tells PG to not allow null
      t.integer :task_id, null: false
      t.timestamps
    end
    add_index :user_tasks, [ :user_id, :task_id ], unique: true
  end
end
