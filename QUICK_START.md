# Quick Start Guide - Brighter Days Photography System

## ✅ System Status

**Backend**: ✅ Complete  
**Database**: ✅ Connected to `capstone_db`  
**Migrations**: ✅ All tables created  
**Seed Data**: ✅ Test users and packages loaded  
**Routes**: ✅ All routes configured  
**Controllers**: ✅ All business logic implemented  

---

## 🚀 Starting the Application

### 1. Start XAMPP Services
```bash
# Open XAMPP Control Panel and start:
- Apache (for web server)
- MySQL (for database)
```

### 2. Start Laravel Development Server
```bash
php artisan serve
```
The application will be available at: **http://localhost:8000**

### 3. Build Frontend Assets (Choose one)

**For Development (with hot reload):**
```bash
npm run dev
```

**For Production:**
```bash
npm run build
```

---

## 👤 Test Accounts

### Business Owner (Full Access)
- **Email**: `owner@brighterdays.ph`
- **Password**: `password`
- **Access**: Analytics, User Management, Package Management, All Reservations

### Event Manager
- **Email**: `manager@brighterdays.ph`
- **Password**: `password`
- **Access**: Reservations, Payment Verification, Calendar, Messaging

### Customer Accounts
**Customer 1:**
- **Email**: `john@example.com`
- **Password**: `password`

**Customer 2:**
- **Email**: `jane@example.com`
- **Password**: `password`

**Access**: Bookings, Themes, Payments, Profile

---

## 📋 Available Routes by Role

### 🎨 Customer Routes
- `GET /customer/dashboard` - Customer dashboard with stats
- `GET /customer/bookings` - View all bookings
- `POST /customer/bookings` - Create new booking
- `GET /customer/themes` - Browse AI themes
- `POST /customer/themes` - Generate new theme
- `POST /customer/bookings/{booking}/payments` - Submit payment

### 👔 Event Manager Routes
- `GET /event-manager/reservations` - All reservations
- `GET /event-manager/calendar` - Calendar view
- `POST /event-manager/reservations/{booking}/confirm` - Confirm booking
- `GET /event-manager/payments` - Payment verification queue
- `POST /event-manager/payments/{payment}/verify` - Verify payment
- `GET /event-manager/messages/{booking}` - Booking messages

### 📊 Business Owner Routes
- `GET /business-owner/analytics` - Analytics dashboard
- `GET /business-owner/users` - User management
- `POST /business-owner/users` - Create new user
- `GET /business-owner/packages` - Package management
- `POST /business-owner/analytics/reports/generate` - Generate custom reports

---

## 🗄️ Database Structure

### Core Tables
1. **users** - 4 seeded (1 owner, 1 manager, 2 customers)
2. **packages** - 4 seeded (Basic, Standard, Premium, Custom)
3. **themes** - Empty (customers will generate)
4. **bookings** - Empty (customers will create)
5. **payments** - Empty (linked to bookings)
6. **messages** - Empty (communication between users)
7. **analytics** - Empty (generated reports stored here)

### Database Info
- **Name**: `capstone_db`
- **Host**: `127.0.0.1`
- **Port**: `3306`
- **User**: `root`
- **Password**: (empty)

---

## 🔧 Common Commands

### Database Management
```bash
# Run migrations
php artisan migrate

# Fresh migration (resets database)
php artisan migrate:fresh

# Seed database
php artisan db:seed

# Fresh migration + seed
php artisan migrate:fresh --seed
```

### Cache & Config
```bash
# Clear application cache
php artisan cache:clear

# Clear config cache
php artisan config:clear

# Clear route cache
php artisan route:clear

# Clear view cache
php artisan view:clear
```

### Development
```bash
# List all routes
php artisan route:list

# Create new controller
php artisan make:controller ControllerName

# Create new model
php artisan make:model ModelName

# Create new migration
php artisan make:migration migration_name
```

---

## 🎯 Testing the System

### Test Customer Flow:
1. Login as `john@example.com`
2. Browse packages at `/customer/dashboard`
3. Create a new booking
4. Generate an AI theme
5. Submit a payment for the booking

### Test Event Manager Flow:
1. Login as `manager@brighterdays.ph`
2. View all reservations
3. Check calendar for conflicts
4. Verify pending payments
5. Confirm bookings

### Test Business Owner Flow:
1. Login as `owner@brighterdays.ph`
2. View analytics dashboard
3. Check revenue and booking stats
4. Manage users (create, edit, deactivate)
5. Manage packages (create, edit, toggle status)
6. Generate custom reports

---

## 🛠️ Troubleshooting

### "Database connection refused"
- Ensure XAMPP MySQL is running
- Check `.env` file has correct database credentials

### "Route not found"
- Run `php artisan route:clear`
- Check middleware is properly configured

### "Class not found"
- Run `composer dump-autoload`

### "Mix manifest not found"
- Run `npm install` then `npm run dev` or `npm run build`

### "Permission denied on storage"
```bash
chmod -R 775 storage bootstrap/cache
```

---

## 📝 Next Steps

### Frontend Implementation (To Do)
The backend is fully functional. To complete the system, create Vue 3 components for:

1. **Customer Views**
   - Dashboard with stats cards
   - Booking form with date picker
   - Theme generator interface
   - Payment submission form

2. **Event Manager Views**
   - Reservation list with filters
   - Calendar component
   - Payment verification interface
   - Messaging system

3. **Business Owner Views**
   - Analytics dashboard with charts
   - User management CRUD
   - Package management CRUD
   - Report generation interface

### Recommended Libraries
- **Charts**: Chart.js or ApexCharts
- **Calendar**: FullCalendar
- **Forms**: VeeValidate
- **Date Picker**: Vue3 Date Picker
- **Notifications**: Vue Toastification

---

## 📞 Support

For technical support or questions:
- Check Laravel logs: `storage/logs/laravel.log`
- Check browser console for frontend errors
- Review database queries in debug mode
- Refer to README_SYSTEM.md for detailed documentation

---

**System Version**: 1.0  
**Last Updated**: December 3, 2025  
**Status**: Ready for Frontend Development
