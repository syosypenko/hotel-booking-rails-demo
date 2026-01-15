class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :hotel, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price_per_night, null: false, precision: 10, scale: 2
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
