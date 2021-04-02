class Team < ApplicationRecord
  validates :name, presence: true
  belongs_to :ground
  has_many :games
end