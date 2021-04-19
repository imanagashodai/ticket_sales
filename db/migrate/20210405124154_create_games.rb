class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :datetime
      t.integer :hometeam_id
      t.integer :visitorteam_id
      t.integer :ground_id
      t.integer :pricegroup

      t.timestamps
    end
  end
end
