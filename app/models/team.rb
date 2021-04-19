class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :ground_id }
  belongs_to :ground, optional: true
  has_many :games
end