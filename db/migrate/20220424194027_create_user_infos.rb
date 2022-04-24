class CreateUserInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_infos do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :phone_number
      t.string :passport_code
      t.references :user, null: false, foreign_key: true
      t.references :discount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
