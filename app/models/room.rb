class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy

  validates :name, :price_per_night, :capacity, presence: true
  validates :price_per_night, numericality: { greater_than: 0 }
  validates :capacity, numericality: { greater_than: 0 }

  def available_on?(check_in, check_out)
    bookings.none? do |booking|
      # Check if date ranges overlap
      !(check_out <= booking.check_in || check_in >= booking.check_out)
    end
  end

  def calculate_price(check_in, check_out)
    nights = (check_out - check_in).to_i
    nights * price_per_night
  end
end
