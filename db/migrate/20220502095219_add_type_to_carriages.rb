class AddTypeToCarriages < ActiveRecord::Migration[7.0]
  def change
    add_reference :carriages, :carriage_type, foreign_key: true
  end
end
