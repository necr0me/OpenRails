class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.references :seat
      t.references :user
      t.references :departure_station
      t.references :destination_station


      t.timestamps
    end
    add_foreign_key :tickets, :seats, column: :seat_id, primary_key: :id
    add_foreign_key :tickets, :users, column: :user_id, primary_key: :id
    add_foreign_key :tickets, :stations, column: :departure_station_id, primary_key: :id
    add_foreign_key :tickets, :stations, column: :destination_station_id, primary_key: :id
  end
end
