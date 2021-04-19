class AddAaaToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :aaa, :integer
  end
end