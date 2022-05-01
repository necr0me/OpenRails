class AddUniqueIndexToStationOrderNumbers < ActiveRecord::Migration[7.0]
  def change
    add_index :station_order_numbers, [:route_id, :order_number], unique: true
  end
end
