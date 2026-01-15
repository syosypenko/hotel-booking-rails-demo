class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.string :guest_name, null: false
      t.string :guest_email, null: false
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.decimal :total_price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
