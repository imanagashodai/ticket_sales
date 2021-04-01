class Team < ApplicationRecord
  validates :name, presence: true
  belongs_to :ground, optional: true
end