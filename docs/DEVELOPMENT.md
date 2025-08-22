# Development Guide - MoneyMate

## Project Setup

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter extensions
- Git for version control

### Initial Setup
```bash
# Clone the repository
git clone https://github.com/nityasundar2743/moneymate.git
cd moneymate

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Architecture

### Project Structure
```
lib/
├── main.dart                     # Application entry point
├── models/                       # Data models
│   ├── expense.dart              # Expense data model
│   └── expense_category.dart     # Category data model
├── services/                     # Business logic layer
│   └── database_service.dart     # SQLite database operations
├── screens/                      # UI screens
│   └── dashboard/
│       └── dashboard_screen.dart # Main dashboard with all pages
├── utils/                        # Utility functions
│   └── app_utils.dart           # Helper functions and utilities
└── widgets/                      # Reusable UI components (future)
```

### Design Patterns

**Singleton Pattern**
- `DatabaseService` uses singleton pattern for single database instance

**Model-View Pattern**
- Models handle data structure and validation
- Views (screens) handle UI and user interaction
- Services handle business logic and data operations

**Future-based Async Pattern**
- All database operations return Futures
- Async/await used throughout for clean code

## Database Design

### SQLite Implementation
MoneyMate uses SQLite for local data storage with the following schema:

#### Expenses Table
```sql
CREATE TABLE expenses(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  amount REAL NOT NULL,
  category TEXT NOT NULL,
  date TEXT NOT NULL,
  notes TEXT
);
```

#### Categories Table
```sql
CREATE TABLE categories(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  icon TEXT NOT NULL,
  color TEXT NOT NULL,
  budgetLimit REAL
);
```

### Database Operations
- **CRUD Operations**: Full Create, Read, Update, Delete support
- **Indexing**: Automatic indexing on primary keys
- **Transactions**: Atomic operations for data integrity
- **Migration**: Version-based schema migration support

## UI/UX Guidelines

### Design System

**Color Palette**
```dart
primary: Color(0xFF00BCD4)      // Cyan
primaryDark: Color(0xFF0097A7)  // Dark Cyan
background: Color(0xFFF0F0F0)   // Light Gray
surface: Color(0xFFFFFFFF)      // White
error: Color(0xFFE57373)        // Light Red
success: Color(0xFF4CAF50)      // Green
```

**Typography**
```dart
// Headings
headline1: 28px, FontWeight.w700
headline2: 24px, FontWeight.w600
headline3: 20px, FontWeight.w600

// Body Text
bodyText1: 16px, FontWeight.w500
bodyText2: 14px, FontWeight.w400
caption: 12px, FontWeight.w400
```

**Spacing System**
- Base unit: 4px
- Common spacing: 8px, 12px, 16px, 20px, 24px, 32px
- Border radius: 12px for cards, 8px for small elements

### Component Guidelines

**Cards**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
)
```

**Buttons**
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF00BCD4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  ),
)
```

## Development Workflow

### Code Style
- Follow Dart style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### File Organization
- One class per file
- Use descriptive file names
- Group related files in directories
- Separate concerns (models, services, UI)

### State Management
Currently using `StatefulWidget` with `setState()`. Future considerations:
- **BLoC Pattern**: For complex state management
- **Riverpod**: For dependency injection and state
- **Provider**: Alternative state management solution

## Testing Strategy

### Unit Tests
```dart
// Example test structure
test('should calculate percentage correctly', () {
  // Arrange
  double part = 25.0;
  double total = 100.0;
  
  // Act
  double result = AppUtils.calculatePercentage(part, total);
  
  // Assert
  expect(result, 25.0);
});
```

### Widget Tests
```dart
testWidgets('should display expense amount', (WidgetTester tester) async {
  // Arrange
  final expense = Expense(/*...*/);
  
  // Act
  await tester.pumpWidget(ExpenseCard(expense: expense));
  
  // Assert
  expect(find.text('£25.00'), findsOneWidget);
});
```

### Integration Tests
- Database operations
- Full user workflows
- Performance testing

## Build and Deployment

### Development Build
```bash
# Debug build
flutter run

# Release build (for testing)
flutter run --release
```

### Production Build

**Android**
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

**iOS**
```bash
# Build for iOS
flutter build ios --release

# Archive for App Store
# Use Xcode for final archiving and submission
```

### Code Signing
- **Android**: Configure signing in `android/app/build.gradle`
- **iOS**: Configure in Xcode project settings

## Performance Optimization

### Database Performance
- Use indexed queries for large datasets
- Implement pagination for expense lists
- Cache frequently accessed data
- Use batch operations for multiple inserts

### UI Performance
- Use `const` constructors where possible
- Implement `ListView.builder` for large lists
- Optimize image loading and caching
- Minimize widget rebuilds

### Memory Management
- Dispose controllers and streams
- Use weak references for callbacks
- Implement proper lifecycle management
- Monitor memory usage in debug mode

## Debugging

### Common Issues

**Database Errors**
```dart
try {
  await DatabaseService.insertExpense(expense);
} catch (e) {
  print('Database error: $e');
  // Handle error appropriately
}
```

**UI Issues**
- Use Flutter Inspector
- Check widget tree structure
- Verify state management
- Test on different screen sizes

**Performance Issues**
- Use Flutter Performance tab
- Check for memory leaks
- Profile on real devices
- Optimize heavy operations

### Debug Tools
- **Flutter Inspector**: Widget tree analysis
- **Performance Tab**: FPS and memory monitoring
- **Network Tab**: API call monitoring (future use)
- **Logging**: Strategic print statements and proper logging

## Contributing

### Pull Request Process
1. Create feature branch from `main`
2. Implement changes with tests
3. Update documentation
4. Submit PR with clear description
5. Address review feedback
6. Merge after approval

### Code Review Checklist
- [ ] Code follows style guidelines
- [ ] Tests pass and coverage maintained
- [ ] Documentation updated
- [ ] No breaking changes (or properly documented)
- [ ] Performance impact considered

### Issue Reporting
Use GitHub issues with:
- Clear title and description
- Steps to reproduce
- Expected vs actual behavior
- Device and version information
- Screenshots/logs if applicable

## Future Roadmap

### Short Term (1-2 months)
- [ ] Enhanced analytics with charts
- [ ] Budget setting and tracking
- [ ] Expense search functionality
- [ ] Data export (CSV/PDF)

### Medium Term (3-6 months)
- [ ] Cloud backup and sync
- [ ] Receipt scanning with OCR
- [ ] Multi-currency support
- [ ] Recurring expense templates

### Long Term (6+ months)
- [ ] AI-powered insights
- [ ] Collaborative expense tracking
- [ ] Investment tracking
- [ ] Advanced reporting dashboard

## Resources

### Documentation
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Docs](https://dart.dev/guides)
- [SQLite Docs](https://www.sqlite.org/docs.html)
- [Material Design](https://material.io/design)

### Tools
- [Flutter Inspector](https://docs.flutter.dev/development/tools/flutter-inspector)
- [Dart DevTools](https://dart.dev/tools/dart-devtools)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

### Community
- [Flutter Discord](https://discord.gg/flutter)
- [Reddit r/FlutterDev](https://www.reddit.com/r/FlutterDev/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

**Happy coding!** 🚀👨‍💻