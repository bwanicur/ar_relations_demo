class Profile < ApplicationRecord
  belongs_to :user # FK is on the users table (because it is has_one / belongs_to) --> users.profile_id
end
