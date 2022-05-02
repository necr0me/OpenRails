class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.integer :number, null: false
      t.boolean :is_taken, null: false, default: false
      t.references :carriage, null: false

      t.timestamps
    end
    add_foreign_key :seats, :carriages, column: :carriage_id, primary_key: :id
  end
end
