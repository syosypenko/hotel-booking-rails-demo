# 🏨 Hotel Booking Rails Demo - Complete Project

## 📋 Project Index

Welcome to the Hotel Booking Rails Demo! This is a complete, production-ready Ruby on Rails application demonstrating Voice AI booking integration.

### 📚 Documentation Files

1. **[README.md](./README.md)** - Main project documentation with architecture overview
2. **[SETUP_COMPLETE.md](./SETUP_COMPLETE.md)** - Complete setup guide and file descriptions
3. **[TESTING.md](./TESTING.md)** - API testing guide and usage examples

### 🏗️ Application Structure

```
📁 Root Directory
├── 📁 app/                 # Rails application code
│   ├── 📁 controllers/     # Request handlers
│   ├── 📁 models/          # Database models
│   └── 📁 views/           # HTML templates
├── 📁 config/              # Configuration files
│   └── 📁 initializers/    # Rails initializers
├── 📁 db/                  # Database files
│   ├── 📁 migrate/         # Migrations (schema)
│   └── seeds.rb            # Sample data
├── 🐳 Dockerfile           # Docker image definition
├── 📝 docker-compose.yml   # Docker Compose config
├── 📦 Gemfile              # Ruby dependencies
└── 📘 Documentation files
```

## 🎯 Key Features

✅ **Homepage** - Modern hotel booking interface with Tailwind CSS  
✅ **Booking System** - Complete booking flow with validation  
✅ **REST APIs** - Three endpoints for Voice AI integration  
✅ **Database** - SQLite with proper schema and relationships  
✅ **Docker** - Complete containerization setup  
✅ **Seed Data** - One hotel with 5 room types  

## 🚀 Quick Start

### Docker (Recommended)
```bash
docker-compose up
# Visit: http://localhost:3000
```

### Local Development
```bash
bundle install
rails db:create db:migrate db:seed
rails server
# Visit: http://localhost:3000
```

## 📖 Application Routes

| Method | Path | Handler | Description |
|--------|------|---------|-------------|
| GET | / | PagesController#home | Homepage with room listing |
| GET | /confirmation/:id | BookingsController#show | Booking confirmation |
| GET | /api/rooms | Api::RoomsController#index | List all rooms (JSON) |
| GET | /api/availability | Api::AvailabilityController#index | Check availability (JSON) |
| POST | /api/bookings | Api::BookingsController#create | Create booking (JSON) |

## 🗄️ Database Models

### Hotel
- Represents the hotel property
- Has many rooms
- Contains: name, description, address, default_language, currency

### Room  
- Hotel room type/category
- Belongs to Hotel
- Has many bookings
- Contains: name, price_per_night, capacity
- Methods: available_on?, calculate_price

### Booking
- Guest reservation
- Belongs to Room
- Contains: guest_name, guest_email, check_in, check_out, total_price
- Validations: dates, email format, availability

## 🔧 Technology Stack

| Component | Technology |
|-----------|-----------|
| Framework | Rails 7.0 |
| Database | SQLite 3 |
| Web Server | Puma |
| Frontend | Tailwind CSS |
| JavaScript | Stimulus Rails |
| Containerization | Docker & Docker Compose |
| API | RESTful JSON |

## 📁 Important Files

### Core Application

| File | Purpose |
|------|---------|
| [config/routes.rb](./config/routes.rb) | URL routing configuration |
| [config/application.rb](./config/application.rb) | Rails settings and middleware |
| [app/models/hotel.rb](./app/models/hotel.rb) | Hotel model |
| [app/models/room.rb](./app/models/room.rb) | Room model with availability logic |
| [app/models/booking.rb](./app/models/booking.rb) | Booking model with validations |

### Controllers

| File | Purpose |
|------|---------|
| [app/controllers/pages_controller.rb](./app/controllers/pages_controller.rb) | Homepage controller |
| [app/controllers/bookings_controller.rb](./app/controllers/bookings_controller.rb) | Booking confirmation |
| [app/controllers/api/rooms_controller.rb](./app/controllers/api/rooms_controller.rb) | Rooms API endpoint |
| [app/controllers/api/availability_controller.rb](./app/controllers/api/availability_controller.rb) | Availability API endpoint |
| [app/controllers/api/bookings_controller.rb](./app/controllers/api/bookings_controller.rb) | Bookings API endpoint |

### Views

| File | Purpose |
|------|---------|
| [app/views/layouts/application.html.erb](./app/views/layouts/application.html.erb) | Main layout template |
| [app/views/pages/home.html.erb](./app/views/pages/home.html.erb) | Homepage with Tailwind styling |
| [app/views/bookings/show.html.erb](./app/views/bookings/show.html.erb) | Booking confirmation page |

### Database

| File | Purpose |
|------|---------|
| [db/migrate/20240101000001_create_hotels.rb](./db/migrate/20240101000001_create_hotels.rb) | Hotels table migration |
| [db/migrate/20240101000002_create_rooms.rb](./db/migrate/20240101000002_create_rooms.rb) | Rooms table migration |
| [db/migrate/20240101000003_create_bookings.rb](./db/migrate/20240101000003_create_bookings.rb) | Bookings table migration |
| [db/seeds.rb](./db/seeds.rb) | Sample data seeding |

### Docker & Configuration

| File | Purpose |
|------|---------|
| [Dockerfile](./Dockerfile) | Docker image specification |
| [docker-compose.yml](./docker-compose.yml) | Docker Compose orchestration |
| [Gemfile](./Gemfile) | Ruby gem dependencies |
| [Gemfile.lock](./Gemfile.lock) | Locked dependency versions |
| [config/database.yml](./config/database.yml) | Database configuration |

## 🌐 API Endpoints

### Get All Rooms
```
GET /api/rooms
Response: [{ id, name, price_per_night, capacity }, ...]
```

### Check Availability  
```
GET /api/availability?check_in=YYYY-MM-DD&check_out=YYYY-MM-DD
Response: [{ room_id, name, price_per_night, available, total_price }, ...]
```

### Create Booking
```
POST /api/bookings
Body: { booking: { room_id, guest_name, guest_email, check_in, check_out } }
Response: { success, booking: { id, room, guest_name, check_in, check_out, total_price } }
```

See [TESTING.md](./TESTING.md) for complete examples.

## 🎙️ Voice AI Integration

This application is designed for Voice AI integration:

1. **APIs are JSON-based** - Easy to parse for AI systems
2. **CORS enabled** - Calls work from external domains
3. **Stateless design** - Each API call is independent
4. **Error messages** - Clear feedback for validation failures
5. **Widget placeholder** - Ready for Voice AI plugin

To integrate:
1. Update the `<div id="voice-ai-widget"></div>` placeholder
2. Call `/api/rooms` to offer room options
3. Call `/api/availability` with user-selected dates
4. Call `/api/bookings` to complete the reservation

## 📊 Seed Data

When `rails db:seed` runs, the following is created:

**Hotel:**
- Grand Plaza Hotel, San Francisco

**Rooms:**
1. Standard Room - $120/night (2 guests)
2. Deluxe Room - $180/night (2 guests)
3. Suite - $250/night (4 guests)
4. Presidential Suite - $500/night (6 guests)
5. Family Room - $200/night (4 guests)

## ✅ Deployment Checklist

- [x] All models created and validated
- [x] Database migrations ready
- [x] API endpoints functional
- [x] Homepage UI complete with Tailwind
- [x] Booking flow implemented
- [x] Error handling in place
- [x] Seed data configured
- [x] Docker configuration complete
- [x] CORS enabled
- [x] Documentation complete
- [ ] Deploy to production (PostgreSQL recommended)
- [ ] Set up monitoring and logging
- [ ] Configure backups

## 🐛 Troubleshooting

See [SETUP_COMPLETE.md](./SETUP_COMPLETE.md) for troubleshooting guide.

## 📞 Support Resources

- [Rails Guides](https://guides.rubyonrails.org)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)
- [SQLite Docs](https://www.sqlite.org/docs.html)
- [Docker Docs](https://docs.docker.com)

## 📄 License

This project is open source and available for educational and commercial use.

---

## 🎯 Next Steps

1. **Run the application:** `docker-compose up`
2. **Test the APIs:** See [TESTING.md](./TESTING.md)
3. **Customize branding:** Update CSS and copy
4. **Integrate Voice AI:** Add your widget to the placeholder
5. **Deploy to production:** Use Docker image with PostgreSQL

---

**Built with ❤️ for Voice AI Integration**

Last Updated: January 14, 2026  
Rails Version: 7.0  
Ruby Version: 3.2
