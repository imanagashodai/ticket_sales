class AddGroundIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :ground_id, :integer
  end
end
