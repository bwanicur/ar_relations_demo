class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true

  has_one :profile  # FK is in the users table: users.profile_id -->  HAS ONE

  has_many :emails  # FK is in the emails table: emails.user_id --> HAVE MANY

  has_many :user_tasks, dependent: :destroy # depenent: :destory deletes orhpaned rows
  has_many :tasks, through: :user_tasks
end
