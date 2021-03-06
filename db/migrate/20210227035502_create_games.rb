class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :date
      t.string :start
      t.integer :home_id
      t.integer :visitor_id
      t.integer :ground_id

      t.timestamps
    end
  end
end
