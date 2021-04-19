class RemoveGameIdFromSeats < ActiveRecord::Migration[5.2]
  def change
    remove_column :seats, :game_id, :integer
  end
end
