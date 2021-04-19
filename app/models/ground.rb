class Ground < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_one :team
  has_many :games
  has_many :seatgroups
end
