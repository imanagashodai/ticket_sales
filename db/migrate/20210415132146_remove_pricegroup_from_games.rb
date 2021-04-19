class RemovePricegroupFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :pricegroup, :integer
  end
end
