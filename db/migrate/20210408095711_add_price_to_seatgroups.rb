class AddPriceToSeatgroups < ActiveRecord::Migration[5.2]
  def change
    add_column :seatgroups, :price, :integer
  end
end
