# MoneyMate - Comprehensive Expense Tracker

MoneyMate is a modern, intuitive expense tracking application built with Flutter. It helps users monitor their spending habits, categorize expenses, and gain insights into their financial behavior through a clean and user-friendly interface.

## 🌟 Features

### Core Functionality
- **Expense Tracking**: Add, edit, and delete expenses with detailed information
- **Category Management**: Organize expenses into predefined or custom categories
- **Real-time Overview**: View current month's spending at a glance
- **Transaction History**: Browse through all past expenses with filtering options
- **Analytics Dashboard**: Insights and charts to understand spending patterns (coming soon)

### User Experience
- **Clean Material Design**: Modern, intuitive interface following Material Design principles
- **Smooth Animations**: Fluid transitions and micro-interactions for better UX
- **Responsive Layout**: Optimized for different screen sizes
- **Quick Actions**: Floating action button for easy expense addition
- **Pull-to-refresh**: Keep data updated with simple gesture

### Technical Features
- **Local Database**: SQLite database for offline functionality
- **Data Persistence**: All data stored securely on device
- **Performance Optimized**: Efficient data handling and smooth scrolling
- **Cross-platform**: Runs on both Android and iOS

## 📱 Screenshots

### Main Dashboard
The overview page shows your current month's total expenses, top spending categories, and recent transactions.

### Expense History
A comprehensive list of all expenses with filtering options and detailed information.

### Add Expense
Simple form to quickly add new expenses with category selection and date picker.

### Categories
Manage and view all expense categories with customizable icons and colors.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/nityasundar2743/moneymate.git
   cd moneymate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── expense.dart          # Expense model
│   └── expense_category.dart # Category model
├── services/                 # Business logic
│   └── database_service.dart # SQLite database operations
├── screens/                  # UI screens
│   └── dashboard/
│       └── dashboard_screen.dart # Main dashboard
├── utils/                    # Utility functions
│   └── app_utils.dart        # Helper functions
└── widgets/                  # Reusable UI components
```

### Database Schema

#### Expenses Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key (auto-increment) |
| title | TEXT | Expense title |
| description | TEXT | Detailed description |
| amount | REAL | Expense amount |
| category | TEXT | Category name |
| date | TEXT | Date in ISO format |
| notes | TEXT | Optional notes |

#### Categories Table
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key (auto-increment) |
| name | TEXT | Category name (unique) |
| icon | TEXT | Icon identifier |
| color | TEXT | Color hex code |
| budgetLimit | REAL | Optional budget limit |

## 🎨 Design System

### Color Palette
- **Primary**: `#00BCD4` (Cyan)
- **Secondary**: `#0097A7` (Dark Cyan)
- **Background**: `#F0F0F0` (Light Gray)
- **Surface**: `#FFFFFF` (White)
- **Error**: `#E57373` (Light Red)
- **Success**: `#4CAF50` (Green)

### Typography
- **Font Family**: Roboto
- **Heading Large**: 28px, Bold
- **Heading Medium**: 20px, Semibold
- **Body Large**: 16px, Medium
- **Body Small**: 14px, Regular
- **Caption**: 12px, Regular

### Components
- **Cards**: Rounded corners (12px), subtle shadow
- **Buttons**: Rounded (12px), no elevation for flat design
- **Text Fields**: Outlined with rounded corners
- **Bottom Navigation**: Fixed, with icons and labels

## 🔧 Configuration

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.2      # Local database
  path_provider: ^2.1.2 # File system paths
  intl: ^0.18.1        # Date formatting
  cupertino_icons: ^1.0.8
  fl_chart: ^1.0.0     # Charts (for future analytics)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

### App Configuration
- **Minimum SDK**: Android 21 (Android 5.0)
- **Target SDK**: Latest Android SDK
- **iOS Deployment Target**: iOS 12.0

## 📊 Usage

### Adding an Expense
1. Tap the floating action button (+) on the Overview or History screen
2. Fill in the expense details:
   - Title (required)
   - Description (required)
   - Amount (required)
   - Category (select from dropdown)
   - Date (defaults to today)
   - Notes (optional)
3. Tap "Add Expense" to save

### Viewing Expenses
- **Overview**: See current month's summary and recent expenses
- **History**: Browse all expenses with filtering options
- **Categories**: View spending by category

### Managing Categories
- Default categories are provided (Food, Transportation, etc.)
- Each category has a specific icon and color
- Budget limits can be set for categories (future feature)

## 🔮 Future Enhancements

### Planned Features
- **Advanced Analytics**: Charts and spending trends
- **Budget Management**: Set and track monthly budgets
- **Expense Search**: Search expenses by title, category, or amount
- **Data Export**: Export data to CSV or PDF
- **Cloud Sync**: Backup and sync across devices
- **Recurring Expenses**: Set up recurring transactions
- **Multi-currency Support**: Handle different currencies
- **Receipt Scanner**: OCR for receipt scanning
- **Spending Insights**: AI-powered spending recommendations

### Technical Improvements
- **State Management**: Implement BLoC or Riverpod for better state management
- **Testing**: Add unit, widget, and integration tests
- **CI/CD**: Set up automated testing and deployment
- **Performance**: Optimize for large datasets
- **Accessibility**: Improve accessibility features

## 🤝 Contributing

We welcome contributions to MoneyMate! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Development Guidelines
- Follow Flutter/Dart coding conventions
- Write meaningful commit messages
- Add comments for complex logic
- Update documentation for new features
- Test your changes thoroughly

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, bug reports, or feature requests:
- Create an issue on GitHub
- Contact: [your-email@example.com]

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design system
- Contributors and testers
- Open source community

---

**MoneyMate** - Take control of your expenses with style! 💰✨
