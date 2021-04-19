class Seat < ApplicationRecord
  belongs_to :seatgroup
  has_many :tickets
  
  validates :name, presence: true, uniqueness: { scope: :seatgroup_id }
end
