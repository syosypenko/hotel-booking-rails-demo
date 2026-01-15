# Clear existing data
Booking.destroy_all
Room.destroy_all
Hotel.destroy_all

# Create hotel
hotel = Hotel.create!(
  name: 'Grand Plaza Hotel',
  description: 'A luxurious 5-star hotel experience with modern amenities and world-class service. Perfect for business travelers and leisure guests.',
  address: '123 Main Street, San Francisco, CA 94102',
  default_language: 'en',
  currency: 'USD'
)

# Create rooms
rooms_data = [
  { name: 'Standard Room', price_per_night: 120, capacity: 2 },
  { name: 'Deluxe Room', price_per_night: 180, capacity: 2 },
  { name: 'Suite', price_per_night: 250, capacity: 4 },
  { name: 'Presidential Suite', price_per_night: 500, capacity: 6 },
  { name: 'Family Room', price_per_night: 200, capacity: 4 }
]

rooms_data.each do |room_data|
  hotel.rooms.create!(room_data)
end

puts "✅ Seeded 1 hotel with #{hotel.rooms.count} rooms"
