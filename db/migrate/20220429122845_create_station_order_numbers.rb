class CreateStationOrderNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :station_order_numbers do |t|
      t.references :route, null: false
      t.references :station, null: false
      t.integer :order_number

      t.timestamps
    end

    add_foreign_key :station_order_numbers, :stations, column: :station_id, primary_key: :id
    add_foreign_key :station_order_numbers, :routes, column: :route_id, primary_key: :id
  end
end
