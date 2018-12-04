class Email < ApplicationRecord
  validate :user_id, presence: true
  belongs_to :user # FK is on the emails table --> emails.user_id (because user has_many tasks)
end
