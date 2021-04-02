class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :datetime
      t.references :hometeam, foreign_key: { to_table: :teams }
      t.references :ground, foreign_key: true
      t.integer :pricegroup

      t.timestamps
    end
  end
end
