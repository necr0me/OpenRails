class AddNameToCarriages < ActiveRecord::Migration[7.0]
  def change
    add_column :carriages, :name, :string, null: true
  end
end
