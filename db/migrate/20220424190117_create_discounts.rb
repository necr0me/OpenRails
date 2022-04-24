class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :description
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
