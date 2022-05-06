class CreateTrains < ActiveRecord::Migration[7.0]
  def change
    create_table :trains do |t|
      t.references :route

      t.timestamps
    end
    add_foreign_key :trains, :routes, column: :route_id, primary_key: :id
  end
end
