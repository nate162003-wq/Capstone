# Brighter Days Photography Event Management System

## System Overview

A comprehensive web-based event management platform specifically built for **Brighter Days Photography PH** to centralize booking, theme generation, cost estimation, and business analytics.

## Key Features

### Problems Solved
- ✅ **Organized Communication**: Centralized messaging system replacing scattered social media conversations
- ✅ **Fast Response**: Real-time notifications and streamlined communication channels
- ✅ **Automated Scheduling**: Prevents double bookings with calendar conflict detection
- ✅ **Centralized Data**: All pricing, packages, and client history in one place
- ✅ **Business Analytics**: Comprehensive dashboard for data-driven decisions

### System Capabilities

#### 🎨 **Customer Features**
- Account registration and profile management
- Browse and select photography packages
- AI-powered theme generation for events
- Book photography events with calendar integration
- Submit payments with proof of payment upload
- Track booking status in real-time
- Communicate directly with event managers
- View booking history and analytics

#### 👔 **Event Manager Features**
- Review and manage reservations
- Calendar view to check date availability and prevent conflicts
- Verify payment submissions with proof review
- Approve or reject bookings
- Communicate with customers via integrated messaging
- Update AI theme outputs and manage customer preferences
- Mark bookings as completed

#### 📊 **Business Owner Features**
- Comprehensive analytics dashboard with:
  - Revenue tracking and trends
  - Booking statistics (confirmed, pending, completed)
  - Customer analytics (new, repeat customers)
  - Popular package performance
  - Event type distribution
- Generate business reports (revenue, bookings, customers)
- Complete user management (customers, managers, admins)
- Package management (create, edit, activate/deactivate)
- Full system oversight and control

## Technology Stack

- **Backend**: Laravel 12.41.1 (PHP 8.4.15)
- **Frontend**: Vue 3.5.22 with Inertia.js 2.2.7
- **Styling**: Tailwind CSS 4.1.14
- **Authentication**: Laravel Fortify 1.32.1 with 2FA support
- **Database**: MySQL (via XAMPP)
- **Testing**: Pest 4.1.6

## Database Structure

### Core Tables
1. **users** - Customer, Event Manager, and Business Owner accounts with RBAC
2. **packages** - Photography packages with pricing and features
3. **themes** - AI-generated event themes
4. **bookings** - Event reservations with customer and package details
5. **payments** - Payment tracking and verification
6. **messages** - In-system communication between customers and managers
7. **analytics** - Business metrics and generated reports

## Installation & Setup

### Prerequisites
- XAMPP (Apache + MySQL)
- PHP 8.4+
- Composer
- Node.js & NPM

### Database Setup

The database `capstone_db` has been created and configured automatically.

### Installation Steps

1. **Install PHP Dependencies**
   ```bash
   composer install
   ```

2. **Install Node Dependencies**
   ```bash
   npm install
   ```

3. **Run Migrations** (Already completed)
   ```bash
   php artisan migrate
   ```

4. **Seed Database** (Already completed)
   ```bash
   php artisan db:seed
   ```

5. **Build Frontend Assets**
   ```bash
   npm run build
   ```
   
   Or for development:
   ```bash
   npm run dev
   ```

6. **Start Laravel Server**
   ```bash
   php artisan serve
   ```

7. **Start XAMPP MySQL**
   - Open XAMPP Control Panel
   - Start Apache and MySQL

## Default User Accounts

### Business Owner
- **Email**: owner@brighterdays.ph
- **Password**: password
- **Role**: Full system access, analytics, user management

### Event Manager
- **Email**: manager@brighterdays.ph
- **Password**: password
- **Role**: Reservation management, payment verification

### Sample Customers
- **Email**: john@example.com / jane@example.com
- **Password**: password
- **Role**: Book events, generate themes, submit payments

## System Routes

### Customer Routes (`/customer/*`)
- Dashboard, bookings, themes, payments

### Event Manager Routes (`/event-manager/*`)
- Reservations, payment verification, calendar, messages

### Business Owner Routes (`/business-owner/*`)
- Analytics, user management, package management, reports

## Security Features

✅ **Role-Based Access Control (RBAC)**
- Three distinct roles with specific permissions
- Middleware protection on all routes
- Policy-based authorization for resources

✅ **Authentication**
- Laravel Fortify with 2FA support
- Secure password hashing
- Session management

✅ **Data Protection**
- Input validation on all forms
- SQL injection prevention via Eloquent ORM
- XSS protection built into Blade/Inertia

## Key Functionalities

### 1. Booking Management
- Create, edit, cancel bookings
- Automatic conflict detection
- Status tracking (pending → confirmed → completed)
- Package and theme association

### 2. Payment Processing
- Multiple payment methods (cash, bank transfer, GCash, PayMaya, credit card)
- Proof of payment upload
- Verification workflow (pending → verified/rejected)
- Payment history tracking

### 3. AI Theme Generation
- Customer can input event preferences
- System generates theme suggestions
- Save favorite themes
- Apply themes to bookings

### 4. Communication System
- Booking-specific messaging
- Read receipts
- Attachment support
- Customer-to-manager communication

### 5. Analytics & Reporting
- Revenue by month charts
- Booking status distribution
- Popular package analysis
- Customer retention metrics
- Custom report generation

### 6. Calendar Management
- Visual calendar view for event managers
- Booking conflict detection
- Availability checking
- Status-based color coding

## Development Notes

### Models & Relationships
- User → hasMany → Bookings, Themes, Payments, Messages
- Booking → belongsTo → User, Package, Theme
- Payment → belongsTo → Booking, User
- Message → belongsTo → Booking, Sender, Receiver

### Policies
- BookingPolicy: Ensures users can only access their own bookings
- Role-based access for managers and owners

### Frontend (To be completed)
- Vue 3 components with Composition API
- Inertia.js for SPA-like experience
- Tailwind CSS for responsive design
- Form validation and error handling

## Future Enhancements

- [ ] AI Integration for actual theme generation (currently simulated)
- [ ] SMS/Email notifications
- [ ] Payment gateway integration (PayMongo, PayPal)
- [ ] Advanced calendar features (drag-and-drop)
- [ ] Mobile app version
- [ ] Client portal with photo delivery
- [ ] Automated backup system
- [ ] Multi-language support

## Support

For issues or questions about the system:
- Check application logs in `storage/logs/`
- Review database queries in debug mode
- Contact system administrator

## License

Proprietary system for Brighter Days Photography PH

---

**System Status**: ✅ Backend Complete | 🔄 Frontend In Progress

Last Updated: December 3, 2025
