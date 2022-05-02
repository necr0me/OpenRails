class CreateCarriages < ActiveRecord::Migration[7.0]
  def change
    create_table :carriages do |t|

      t.timestamps
    end
  end
end
