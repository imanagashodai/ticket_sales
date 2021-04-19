class AddNameToSeats < ActiveRecord::Migration[5.2]
  def change
    add_column :seats, :name, :string
  end
end
