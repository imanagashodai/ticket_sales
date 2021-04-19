class Purchase < ApplicationRecord
  validates :ticket_id, uniqueness: true
  
  belongs_to :ticket
  belongs_to :user
end
