class CreateSeatgroups < ActiveRecord::Migration[5.2]
  def change
    create_table :seatgroups do |t|
      t.string :name
      t.integer :ground_id

      t.timestamps
    end
  end
end
