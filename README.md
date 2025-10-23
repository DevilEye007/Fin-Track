
# FinTrack - Personal Expense Tracker

<div align="center">

**Track your expenses effortlessly with this beautiful and intuitive Flutter app**

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

## App Overview

FinTrack is a modern, user-friendly expense tracking application built with Flutter. It helps you monitor your spending habits, categorize expenses, and gain insights into your financial patterns with beautiful visualizations.

### Key Features

- **Easy Expense Tracking** - Quickly add expenses with categories
- **Visual Analytics** - Pie charts and spending insights
- **Category Management** - Organize expenses by categories
- **Local Storage** - Your data stays secure on your device
- **Beautiful UI** - Modern Material Design 3 interface
- **Responsive Design** - Works perfectly on all screen sizes
- **Privacy First** - No internet required, no data collection


## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- Android Studio or VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DevilEye007/fin_track.git
   cd fin_track

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

## Technical Stack

### Frameworks & Languages
- **Flutter** - UI framework
- **Dart** - Programming language

### Packages & Dependencies
- `sqflite` - Local database for data persistence
- `url_launcher` - For external links in developer info
- `path` - File path utilities

### Architecture
- **MVVM Pattern** - Model-View-ViewModel architecture
- **SQLite Database** - Local data storage
- **Material Design 3** - Modern UI components

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── expense.dart         # Expense data model
├── screens/
│   ├── home_screen.dart     # Main dashboard
│   ├── add_expense_screen.dart # Add new expense
│   ├── chart_screen.dart    # Analytics and charts
│   └── developer_info_screen.dart # App information
├── widgets/
│   ├── expense_card.dart    # Expense list item
│   └── chart.dart           # Chart components
└── utils/
    ├── colors.dart          # App color scheme
    └── database_helper.dart # Database operations
```

## Color Scheme

FinTrack uses a modern purple color scheme:

| Color | Hex | Usage |
|-------|-----|-------|
| Primary | `#6C63FF` | Main brand color |
| Secondary | `#4A44B8` | Secondary elements |
| Background | `#F5F5F5` | App background |
| Text Dark | `#333333` | Primary text |
| Text Light | `#666666` | Secondary text |

## Features in Detail

### Expense Management
- Add expenses with title, amount, category, and date
- Categorize expenses (Food, Transport, Shopping, etc.)
- View all expenses in a beautiful list
- Delete unwanted expenses
- Real-time total spending calculation

### Analytics & Insights
- Visual spending breakdown by category
- Percentage distribution of expenses
- Clean and intuitive chart representations

### Data Management
- Local SQLite database storage
- Data persistence across app restarts
- Fast and efficient data operations




## Developer

**Faizan Sultan**
- GitHub: [@DevilEye007](https://github.com/DevilEye007)
- Email: fs6700408@gmail.com
- Portfolio: [faizan-posrfolio.vercel.app](https://faizan-posrfolio.vercel.app)

## Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design system
- SQLite for reliable local storage
- The open-source community for inspiration

---

<div align="center">

**If you like this project, don't forget to give it a ⭐!**

*"Track smart, spend wiser"* 💫

</div>