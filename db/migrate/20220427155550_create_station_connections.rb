class CreateStationConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :station_connections do |t|
      t.references :station, null: false
      t.references :connected_station, null: false

      t.timestamps
    end

    add_foreign_key :station_connections, :stations, column: :station_id, primary_key: :id
    add_foreign_key :station_connections, :stations, column: :connected_station_id, primary_key: :id
  end
end
