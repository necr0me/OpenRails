class AddNameToTrains < ActiveRecord::Migration[7.0]
  def change
    add_column :trains, :name, :string
  end
end
