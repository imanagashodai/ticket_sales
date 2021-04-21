class Cart < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  
  validates :ticket_id, presence: true, uniqueness: { scope: :user_id }
end
