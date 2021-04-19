class RemoveUserIdFromSeats < ActiveRecord::Migration[5.2]
  def change
    remove_column :seats, :user_id, :integer
  end
end
