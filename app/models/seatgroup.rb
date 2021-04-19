class Seatgroup < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: [:ground_id, :price] }
  validates :price, presence: true
  belongs_to :ground
  has_many :seats
  has_many :tickets, through: :seats
end
