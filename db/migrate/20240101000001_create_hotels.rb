class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.text :description
      t.string :address
      t.string :default_language, default: 'en'
      t.string :currency, default: 'USD'

      t.timestamps
    end
  end
end
