class CreatePassingTrains < ActiveRecord::Migration[7.0]
  def change
    create_table :passing_trains do |t|
      t.references :train
      t.references :station
      t.datetime :arrival_time
      t.datetime :departure_time

      t.timestamps
    end
    add_foreign_key :passing_trains, :trains, column: :train_id, primary_key: :id
    add_foreign_key :passing_trains, :stations, column: :station_id, primary_key: :id
  end
end
