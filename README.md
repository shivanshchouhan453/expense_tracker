# Expense Tracker 📊

A beautiful and intuitive Flutter application designed to help users track their daily expenses, manage budgets, and visualize spending patterns with detailed charts and analytics.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Architecture](#architecture)

---

## Features ✨

### 💰 Transaction Management
- **Add Expenses**: Quickly log expenses with date, amount, category, and description
- **Categorized Tracking**: Organize expenses by predefined categories (Food, Transport, Shopping, Bills, Entertainment, etc.)
- **Transaction History**: View detailed list of all transactions with full details
- **Edit & Delete**: Modify or remove transactions with ease

### 📊 Dashboard & Analytics
- **Balance Dashboard**: View comprehensive financial summary
- **Spending Charts**: Visual representation of spending patterns using interactive charts
- **Category Breakdown**: Analyze expenses by category
- **Time-based Analysis**: View spending trends over different time periods

### 🔐 Authentication
- **User Registration**: Create account with email and secure password
- **User Login**: Secure login system with credentials verification
- **Session Management**: Persistent user sessions

### 👤 Profile & Settings
- **User Profile**: Manage user information and preferences
- **Dark Mode**: Toggle between light and dark themes
- **Theme Support**: Seamless dark/light mode switching with preference persistence

### 🗂️ Data Management
- **Local Storage**: Expenses stored locally using Hive database
- **Data Persistence**: All data persists across app sessions
- **Offline Support**: Full functionality without internet connection

---

## Screenshots 📱

### Authentication Screens
The app includes secure authentication features with:
- **Sign Up Screen**: User registration interface
- **Sign In Screen**: User login interface
- **Auth Gate**: Automatic routing based on authentication state

### Main Application Screens

#### Home Screen
- Display transaction list with all recorded expenses
- Quick access to add new transactions
- View transaction details and history

#### Add Transaction Screen
- Intuitive form to input expense details:
  - Amount field
  - Category selector with category icons
  - Date picker for transaction date
  - Description/notes field
  - Save or cancel options

#### Balance Dashboard
- Summary of total expenses
- Category-wise breakdown
- Visual charts showing spending distribution
- Financial overview and analytics

#### Profile Screen
- User account information
- Theme toggle (Light/Dark mode)
- App settings and preferences
- User profile management

---

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed on your system:

1. **Flutter SDK** (version 3.11.4 or higher)
   - Download from: https://flutter.dev/docs/get-started/install

2. **Dart** (comes with Flutter)

3. **Git**

4. **Development Tools**:
   - **Android**: Android Studio with SDK 21+, or Android SDK Command-line tools
   - **iOS**: Xcode (for macOS users)
   - **Windows**: Visual Studio Community with C++ development tools
   - **Linux**: Required build dependencies

### Installation

#### Step 1: Clone the Repository
```bash
git clone https://github.com/shivanshchouhan453/expense_tracker.git
cd expense_tracker
```

#### Step 2: Get Flutter Dependencies
```bash
flutter pub get
```

#### Step 3: Generate Local Storage
```bash
flutter pub run build_runner build
```

This command generates necessary files for Hive database configuration.

#### Step 4: Configure Platform-Specific Dependencies

**For Android:**
```bash
cd android
./gradlew build
cd ..
```

**For iOS** (macOS only):
```bash
cd ios
pod install
cd ..
```

### Running the App

#### Check Connected Devices
```bash
flutter devices
```

#### Run on Specific Device
```bash
# Run on Android emulator or device
flutter run -d <device-id>

# Or simply
flutter run
```

#### Run with Specific Configuration
```bash
# Run in debug mode
flutter run

# Run in release mode (optimized)
flutter run --release

# Run in profile mode (performance monitoring)
flutter run --profile
```

#### Development with Hot Reload
```bash
flutter run
# Press 'r' to hot reload
# Press 'R' to hot restart
# Press 'q' to quit
```

---

## Tech Stack 🛠️

### Frontend Framework
- **Flutter**: ^3.11.4 - Cross-platform mobile development
- **Dart**: Programming language for Flutter

### State Management
- **Flutter Riverpod**: ^2.4.0 - State management and dependency injection

### Local Storage
- **Hive**: ^2.2.3 - Lightweight local key-value database
- **Hive Flutter**: ^1.1.0 - Hive integration for Flutter
- **Path Provider Android**: 2.2.17 - File path management

### UI & Utilities
- **Cupertino Icons**: ^1.0.8 - iOS-style icons
- **FL Chart**: ^0.68.0 - Interactive charts and graphs
- **Intl**: ^0.20.2 - Internationalization support
- **UUID**: ^4.5.3 - Unique identifier generation

---

## Dependencies Overview

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_riverpod | ^2.4.0 | State management |
| hive | ^2.2.3 | Local database |
| fl_chart | ^0.68.0 | Charts and graphs |
| intl | ^0.20.2 | Date/time formatting |
| uuid | ^4.5.3 | Unique identifiers |
| path_provider_android | 2.2.17 | File paths |

---

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Acknowledgments 🙏

- Flutter community for excellent documentation
- Riverpod for state management solution
- Hive for local storage solution

---

**Happy Expense Tracking! 💸**

*Last Updated: April 2026*
