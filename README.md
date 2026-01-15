# Hotel Booking Rails Demo

A Ruby on Rails demo hotel booking application built to showcase real-world integration with a Voice AI hotel booking assistant.

This project simulates a modern hotel website with basic booking functionality and clean APIs that can be consumed by a Voice AI plugin.

## 🎯 Purpose

This app exists to demonstrate:

- ✅ How a traditional hotel website can integrate Voice AI booking
- ✅ Clean Rails API design for conversational systems  
- ✅ A realistic SaaS-style demo, not a toy app
- ✅ Intentionally simple, readable, and production-minded

## ✨ Features

- 🏠 Modern hotel homepage with Tailwind CSS
- 🛏️ Room listing with pricing and capacity info
- 📅 Date-based booking flow with availability checking
- ✅ Booking confirmation page
- 🎙️ Voice AI widget integration placeholder
- 🔌 JSON APIs for Voice AI assistant
- 🗄️ SQLite database with proper migrations
- 🐳 Docker & Docker Compose setup

## 🏗️ Architecture

```
Rails App (Hotel Website)
 ├── Homepage & Booking UI (Tailwind CSS)
 ├── Hotel / Room / Booking Models
 ├── REST APIs (JSON)
 └── Voice AI Widget Placeholder
        ↓
   Voice AI Assistant (external plugin)
```

Rails acts as the backend + demo frontend.
Voice AI remains a reusable external component.

## 🧩 Data Models

### Hotel
- `name` - Hotel name
- `description` - Hotel description  
- `address` - Hotel address
- `default_language` - Default language (e.g., "en")
- `currency` - Currency code (e.g., "USD")

### Room
- `hotel_id` - Reference to Hotel
- `name` - Room name/type
- `price_per_night` - Decimal price
- `capacity` - Number of guests

### Booking
- `room_id` - Reference to Room
- `guest_name` - Guest's full name
- `guest_email` - Guest's email
- `check_in` - Check-in date
- `check_out` - Check-out date
- `total_price` - Total booking price

## 🔌 API Endpoints (Voice AI Integration)

These endpoints are designed to be consumed by a Voice AI assistant.

### Get All Rooms
```
GET /api/rooms
```

Response:
```json
[
  {
    "id": 1,
    "name": "Deluxe Room",
    "price_per_night": 180,
    "capacity": 2
  }
]
```

### Check Availability
```
GET /api/availability?check_in=2024-01-15&check_out=2024-01-20
```

Response:
```json
[
  {
    "room_id": 1,
    "name": "Deluxe",
    "price_per_night": 180,
    "available": true,
    "total_price": 900
  }
]
```

### Create Booking
```
POST /api/bookings
Content-Type: application/json

{
  "booking": {
    "room_id": 1,
    "guest_name": "John Doe",
    "guest_email": "john@example.com",
    "check_in": "2024-01-15",
    "check_out": "2024-01-20"
  }
}
```

Response:
```json
{
  "success": true,
  "booking": {
    "id": 1,
    "room": "Deluxe",
    "guest_name": "John Doe",
    "check_in": "2024-01-15",
    "check_out": "2024-01-20",
    "total_price": "900.00"
  }
}
```

## 🎙️ Voice AI Integration

The homepage includes a placeholder for a Voice AI booking widget:

```html
<div id="voice-ai-widget"></div>
```

The Voice AI assistant:
- Captures user voice input
- Calls Rails APIs to fetch rooms, check availability, and create bookings
- Returns booking results via speech

This separation keeps the system modular and scalable.

## 🎨 UI & UX

- Clean, responsive design using Tailwind CSS
- Simple single-page booking flow
- Neutral design suitable for demos
- Focus on clarity over heavy styling
- Real-time price calculation

## 🛠️ Tech Stack

- **Ruby on Rails** (8.0+) - Web framework
- **SQLite** - Database (dev/demo)
- **Tailwind CSS** - Styling
- **Puma** - Web server
- **Docker** - Containerization
- **RESTful Controllers** - API design
- **Server-rendered Views** + JSON APIs

## 🚀 Getting Started

### Option 1: Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/your-username/hotel-booking-rails-demo.git
cd hotel-booking-rails-demo

# Build and start with Docker Compose
docker-compose up --build

# The app will be available at http://localhost:3000
```

### Option 2: Local Rails Server

```bash
# Install dependencies
bundle install

# Create database and seed data
rails db:create db:migrate db:seed

# Start the Rails server
rails server

# Visit http://localhost:3000
```

## 🌱 Seed Data

The application seeds with:
- 1 demo hotel (Grand Plaza Hotel)
- 5 room types with varying prices and capacity
- Ready-to-use sample pricing

This allows the Voice AI assistant to work immediately.

## 📁 Project Structure

```
.
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── pages_controller.rb
│   │   ├── bookings_controller.rb
│   │   └── api/
│   │       ├── rooms_controller.rb
│   │       ├── availability_controller.rb
│   │       └── bookings_controller.rb
│   ├── models/
│   │   ├── hotel.rb
│   │   ├── room.rb
│   │   └── booking.rb
│   └── views/
│       ├── layouts/
│       │   └── application.html.erb
│       ├── pages/
│       │   └── home.html.erb
│       └── bookings/
│           └── show.html.erb
├── config/
│   ├── application.rb
│   ├── routes.rb
│   ├── boot.rb
│   ├── environment.rb
│   └── database.yml
├── db/
│   ├── seeds.rb
│   └── migrate/
│       ├── 20240101000001_create_hotels.rb
│       ├── 20240101000002_create_rooms.rb
│       └── 20240101000003_create_bookings.rb
├── Dockerfile
├── docker-compose.yml
├── Gemfile
├── Gemfile.lock
└── README.md
```

## 🔧 Configuration

### Database
SQLite is configured for development. For production, consider PostgreSQL or MySQL.

### CORS
CORS is enabled for all origins to allow Voice AI widgets to call the API from external domains.

### Rails Environment
- Development: Hot reload, detailed errors
- Production: Optimized performance, security headers

## 📝 API Examples Using cURL

```bash
# Get all rooms
curl http://localhost:3000/api/rooms

# Check availability
curl "http://localhost:3000/api/availability?check_in=2024-01-15&check_out=2024-01-20"

# Create booking
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

## 🐛 Troubleshooting

### Port 3000 already in use
```bash
# Kill the process using port 3000
lsof -ti:3000 | xargs kill -9

# Or use a different port
rails server -p 3001
```

### Database errors
```bash
# Reset the database
rails db:drop db:create db:migrate db:seed
```

### Docker issues
```bash
# Rebuild images
docker-compose build --no-cache

# View logs
docker-compose logs -f web
```

## 📚 Learning Resources

- [Rails Documentation](https://guides.rubyonrails.org)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [RESTful API Design](https://restfulapi.net)
- [Voice AI Integration Patterns](https://example.com)

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

**Built with ❤️ for Voice AI integration**
