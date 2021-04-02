class Ground < ApplicationRecord
  validates :name, presence: true
  has_one :team
  has_many :games
end
