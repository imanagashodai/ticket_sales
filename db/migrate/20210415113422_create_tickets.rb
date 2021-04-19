class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :game_id
      t.integer :seat_id

      t.timestamps
    end
  end
end
