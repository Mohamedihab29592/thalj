# Thalj — ثلج

A Flutter mobile application (iOS & Android) that connects **drivers** and **clients** for product delivery. Clients post shipment orders, drivers browse and send price offers, and an admin panel handles driver verification and subscription management.

**Play Store:** https://play.google.com/store/apps/details?id=com.ihab.thalj

---

## Features

### Client / Driver
- Splash & onboarding screens
- Authentication: sign up, sign in, forgot password, OTP/email verification, password reset
- Home feed: browse available delivery orders with full shipment details (sender/recipient info, weight, temperature, humidity)
- Send price offers on orders and track accepted offers
- Profile management: edit name, email, phone number, and password
- Subscription screen and payment receipt upload

### Driver Verification Flow
New drivers must upload the following documents before they can accept orders:
1. National ID (front & back)
2. Driving license
3. Vehicle registration
4. Operating card
5. Transfer document
6. Commercial registry (optional)

Documents are reviewed by the admin team; drivers are notified once approved.

### Admin Panel
- Review submitted driver documents
- Accept or reject driver applications
- View client payment receipts
- View driver subscription invoices
- Sign out

---

## Tech Stack

| Category | Package |
|---|---|
| State management | `flutter_bloc` + `bloc` |
| Networking | `http` |
| Local storage | `shared_preferences` |
| Image picking | `image_picker` |
| Responsive UI | `flutter_screenutil` |
| Fonts | `google_fonts` |
| Image caching | `cached_network_image` |
| Loading skeletons | `shimmer` |
| Connectivity | `internet_connection_checker` |
| OTP input | `flutter_otp_text_field` |

---

## Architecture

The project follows **MVVM** with **BLoC** as the state management layer.

```
thalj/
├── android/
├── ios/
├── assets/
│   └── images/
├── lib/
│   ├── core/
│   │   ├── errors/          # Internet connectivity check
│   │   ├── functions/       # Shared utilities (image picker, result wrapper)
│   │   ├── local/           # SharedPreferences helper
│   │   ├── network/         # Error models
│   │   ├── routes/          # Named route definitions
│   │   ├── theme/           # App theme
│   │   ├── utils/           # Colors, strings, text styles, assets
│   │   └── widgets/         # Shared reusable widgets
│   ├── features/
│   │   ├── splash/          # Splash & onboarding
│   │   ├── auth/            # Sign in, sign up, OTP, forgot/reset password
│   │   ├── home/            # Order feed, offer submission, profile, subscription
│   │   ├── documents/       # Document upload & verification status
│   │   └── adminHome/       # Admin panel (driver review, invoices)
│   └── main.dart
└── test/
```

Each feature is structured as:
```
feature/
├── data/          # Remote data sources (API calls)
├── domain/        # Models & repository contracts
└── presentation/
    ├── bloc/      # BLoC events, states, and logic
    ├── components/ # Feature-specific widgets
    └── screens/   # Full screens
```

---

## Getting Started

**Prerequisites:** Flutter SDK `>=3.0.5 <4.0.0`

```bash
# Install dependencies
flutter pub get

# Run on a connected device / emulator
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

---

## Environment

The app connects to a single REST API:

```
https://mircle50-001-site1.atempurl.com/
```

Authentication tokens are stored locally with `SharedPreferences` (`loginToken` for drivers/clients, `adminToken` for admins). The app reads these on startup to decide the initial screen.
