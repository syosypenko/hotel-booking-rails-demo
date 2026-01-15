# 🏨 Hotel Booking Rails Demo - Testing Guide

## 🚀 How to Run the Application

### Docker Method (Recommended)

```bash
cd /Users/serhiyyosypenko/projects/hotel-booking-rails-demo
docker-compose up
```

The first time you run this, it will:
1. Build the Docker image
2. Start the Rails container
3. Run database migrations
4. Seed sample data
5. Start the web server on port 3000

**Wait 2-3 minutes for first startup**

Then visit: **http://localhost:3000**

### Local Method

```bash
cd /Users/serhiyyosypenko/projects/hotel-booking-rails-demo
bundle install
rails db:create db:migrate db:seed
rails server
```

Visit: **http://localhost:3000**

## 🌐 Web Interface URLs

### Homepage
- URL: `http://localhost:3000`
- Features:
  - Room listing with pricing
  - Booking form
  - Date picker for check-in/check-out
  - Guest name and email fields
  - Real-time price calculation
  - Voice AI widget placeholder

### Booking Confirmation
- URL: `http://localhost:3000/confirmation/:id`
- Example: `http://localhost:3000/confirmation/1`
- Shows:
  - Booking confirmation details
  - Guest information
  - Room details
  - Total price
  - Confirmation number

## 🔌 API Testing

### 1. Get All Rooms

**URL:** `http://localhost:3000/api/rooms`

**Method:** GET

**cURL:**
```bash
curl http://localhost:3000/api/rooms
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Standard Room",
    "price_per_night": 120,
    "capacity": 2
  },
  {
    "id": 2,
    "name": "Deluxe Room",
    "price_per_night": 180,
    "capacity": 2
  },
  {
    "id": 3,
    "name": "Suite",
    "price_per_night": 250,
    "capacity": 4
  },
  {
    "id": 4,
    "name": "Presidential Suite",
    "price_per_night": 500,
    "capacity": 6
  },
  {
    "id": 5,
    "name": "Family Room",
    "price_per_night": 200,
    "capacity": 4
  }
]
```

### 2. Check Availability

**URL:** `http://localhost:3000/api/availability`

**Method:** GET

**Query Parameters:**
- `check_in`: Date in YYYY-MM-DD format
- `check_out`: Date in YYYY-MM-DD format

**cURL:**
```bash
curl "http://localhost:3000/api/availability?check_in=2024-01-15&check_out=2024-01-20"
```

**Response:**
```json
[
  {
    "room_id": 1,
    "name": "Standard Room",
    "price_per_night": 120,
    "available": true,
    "total_price": 600
  },
  {
    "room_id": 2,
    "name": "Deluxe Room",
    "price_per_night": 180,
    "available": true,
    "total_price": 900
  },
  {
    "room_id": 3,
    "name": "Suite",
    "price_per_night": 250,
    "available": true,
    "total_price": 1250
  },
  {
    "room_id": 4,
    "name": "Presidential Suite",
    "price_per_night": 500,
    "available": true,
    "total_price": 2500
  },
  {
    "room_id": 5,
    "name": "Family Room",
    "price_per_night": 200,
    "available": true,
    "total_price": 1000
  }
]
```

### 3. Create Booking

**URL:** `http://localhost:3000/api/bookings`

**Method:** POST

**Headers:** `Content-Type: application/json`

**cURL:**
```bash
curl -X POST http://localhost:3000/api/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "booking": {
      "room_id": 1,
      "guest_name": "John Doe",
      "guest_email": "john@example.com",
      "check_in": "2024-01-15",
      "check_out": "2024-01-20"
    }
  }'
```

**Success Response (201 Created):**
```json
{
  "success": true,
  "booking": {
    "id": 1,
    "room": "Standard Room",
    "guest_name": "John Doe",
    "check_in": "2024-01-15",
    "check_out": "2024-01-20",
    "total_price": "600.00"
  }
}
```

**Error Response (422 Unprocessable Entity):**
```json
{
  "success": false,
  "errors": [
    "Guest email is invalid",
    "Room is not available for the selected dates"
  ]
}
```

## 🧪 Testing Scenarios

### Scenario 1: View Available Rooms
1. Visit `http://localhost:3000`
2. See list of 5 rooms with prices
3. Check API: `curl http://localhost:3000/api/rooms`

### Scenario 2: Check Availability
1. Pick check-in and check-out dates on homepage
2. See rooms with calculated total price
3. Test API: `curl "http://localhost:3000/api/availability?check_in=2024-01-15&check_out=2024-01-20"`

### Scenario 3: Make a Booking
1. Fill in booking form on homepage:
   - Check-in: Any future date
   - Check-out: After check-in
   - Room: Select any room
   - Name: Your name
   - Email: Your email
2. Click "Book Now"
3. See confirmation page with booking details

### Scenario 4: API Booking
```bash
curl -X POST http://localhost:3000/api/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "booking": {
      "room_id": 2,
      "guest_name": "Jane Smith",
      "guest_email": "jane@example.com",
      "check_in": "2024-02-01",
      "check_out": "2024-02-05"
    }
  }'
```

### Scenario 5: Test Validation
Try creating a booking with:
- Invalid email format
- Check-out before check-in
- Non-existent room ID
- Already booked dates

All should return appropriate error messages.

## 📊 Database Queries

### Check Bookings
```bash
docker-compose exec web rails db:seed:dump
# or
docker-compose exec web rails console
# Then: Booking.all
```

### View Hotels
```bash
docker-compose exec web rails console
Hotel.all.each { |h| puts "#{h.name}: #{h.rooms.count} rooms" }
```

### View Rooms
```bash
docker-compose exec web rails console
Room.all.each { |r| puts "#{r.name}: $#{r.price_per_night}/night" }
```

## 🛠️ Docker Commands

### View Logs
```bash
docker-compose logs web          # Current logs
docker-compose logs web -f       # Follow logs
docker-compose logs web --tail 50  # Last 50 lines
```

### Execute Commands
```bash
docker-compose exec web rails console
docker-compose exec web bundle exec rake db:seed
docker-compose exec web bundle exec rails db:reset
```

### Stop/Start
```bash
docker-compose pause             # Pause containers
docker-compose unpause           # Resume containers
docker-compose stop              # Stop containers
docker-compose start             # Start containers
docker-compose restart           # Restart containers
docker-compose down              # Stop and remove containers
docker-compose down -v           # Stop and remove with volumes
```

## 🎯 Voice AI Integration Points

The application is designed for Voice AI integration:

1. **Fetch Rooms:** Call `/api/rooms` to get available options
2. **Check Availability:** Call `/api/availability` with date parameters
3. **Confirm Booking:** Call `/api/bookings` with guest details
4. **CORS Enabled:** API accepts requests from any origin
5. **JSON Responses:** All APIs return structured JSON for easy parsing

## ✅ Verification Checklist

After running the application:

- [ ] Homepage loads at `http://localhost:3000`
- [ ] All 5 room types are displayed
- [ ] Date picker works for check-in/check-out
- [ ] Price calculates in real-time when dates change
- [ ] Booking form can be submitted
- [ ] Confirmation page shows after booking
- [ ] GET `/api/rooms` returns 5 rooms
- [ ] GET `/api/availability?check_in=2024-01-15&check_out=2024-01-20` works
- [ ] POST `/api/bookings` creates booking successfully
- [ ] Invalid bookings return error messages
- [ ] Database was seeded with sample data

## 📝 Notes

- Application uses SQLite database (file-based, no setup needed)
- Database file: `db/development.sqlite3`
- All data is reset each time `docker-compose up` runs
- CORS is enabled for all origins
- Sessions are stored in cookies (development mode)
- No authentication required for testing

## 🚀 Next Steps

1. Test the application thoroughly
2. Integrate with your Voice AI system
3. Customize branding and styling
4. Add authentication and admin panel
5. Connect to payment processor
6. Deploy to production

---

Happy testing! 🎉
