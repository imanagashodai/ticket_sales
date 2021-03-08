class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.date :date
      t.time :time
      t.integer :homeid
      t.integer :visitorid
      t.integer :ground_id
      t.integer :pricegroup

      t.timestamps
    end
  end
end
