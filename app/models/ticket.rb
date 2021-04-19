class Ticket < ApplicationRecord
  belongs_to :seat
  belongs_to :game
  has_one :purchase
  
  validates :game_id, uniqueness: { scope: :seat_id }
  # validate :ground_match

  # def ground_match
  #   if seat.seatgroup.ground_id != game.ground_id
  #     errors.add(:valid, "グラウンドが共通でない")
  #   end
  # end
end
