class UserTask < ApplicationRecord
  validates :user_id, :task_id, presence: true
  validates :user_id, uniquness: {scope: :task_id}

  belongs_to :user #FK is in the users_tasks table --> user_tasks.user_id
  belongs_to :task  #FK is in the users_tasks table --> user_tasks.task_id
  
end
