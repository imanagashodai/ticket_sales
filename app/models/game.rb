class Game < ApplicationRecord
  belongs_to :hometeam, class_name: "Team", optional: true
  belongs_to :ground, optional: true
end
