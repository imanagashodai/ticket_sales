class CreateGrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :grounds do |t|
      t.string :name

      t.timestamps
    end
  end
end
