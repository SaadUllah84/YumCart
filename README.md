# YumCart - Food Delivery App

A modern, full-featured food delivery mobile application built with Flutter.

## ✨ Features
- Browse restaurants and menus with real-time updates
- Advanced search and category filters
- Secure payments via Stripe
- Firebase Authentication & Firestore
- Order tracking
- User profile management
- Admin panel for restaurant management
## 🛠 Tech Stack
- Frontend: Futter (Dart)
- Backend: Firebase (Auth, Firestore, Storage)
- Payments: Stripe
- Architecture: Feature-based structure with clean, reusable components

## 📂 Project Structure
lib/
├── core/          # Common utilities, themes, constants
├── features/      # Feature-based folders
│   ├── auth/
│   ├── home/
│   ├── restaurant/
│   ├── cart/
│   ├── order/
│   └── profile/
├── services/      # Firebase, Stripe, API services
└── widgets/       # Reusable UI components

## 🚀 How to Run

1. Clone the repo
2. `flutter pub get`
3. Setup Firebase project and add your `google-services.json` & `GoogleService-Info.plist`
4. Add your Stripe publishable key
5. `flutter run`
