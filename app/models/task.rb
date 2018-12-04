class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks
end
