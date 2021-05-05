class Game < ApplicationRecord
  belongs_to :hometeam, class_name: "Team"
  belongs_to :visitorteam, class_name: "Team"
  belongs_to :ground
  has_many :seatgroups, through: :ground
  has_many :tickets
  has_many :purchases, through: :tickets
  
  validates :datetime, presence: true, uniqueness: { scope: [:hometeam_id, :visitorteam_id, :ground_id] }
  validate :teams_same?
  
  def teams_same?
    if hometeam_id == visitorteam_id
      errors.add(:hometeam, "とビジター球団が同じです")
    end
  end
end
