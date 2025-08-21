# API Documentation - MoneyMate Database Service

## DatabaseService Class

The `DatabaseService` class provides all database operations for the MoneyMate app using SQLite.

### Database Schema

#### Tables

##### expenses
```sql
CREATE TABLE expenses(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  amount REAL NOT NULL,
  category TEXT NOT NULL,
  date TEXT NOT NULL,
  notes TEXT
)
```

##### categories
```sql
CREATE TABLE categories(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  icon TEXT NOT NULL,
  color TEXT NOT NULL,
  budgetLimit REAL
)
```

### Expense Operations

#### insertExpense(Expense expense)
Inserts a new expense into the database.

**Parameters:**
- `expense`: Expense object to insert

**Returns:** `Future<int>` - The ID of the inserted expense

**Example:**
```dart
final expense = Expense(
  title: 'Coffee',
  description: 'Morning coffee',
  amount: 4.50,
  category: 'Food & Dining',
  date: DateTime.now(),
);

int id = await DatabaseService.insertExpense(expense);
```

#### getAllExpenses()
Retrieves all expenses ordered by date (newest first).

**Returns:** `Future<List<Expense>>` - List of all expenses

**Example:**
```dart
List<Expense> expenses = await DatabaseService.getAllExpenses();
```

#### getExpensesByCategory(String category)
Retrieves expenses filtered by category.

**Parameters:**
- `category`: Category name to filter by

**Returns:** `Future<List<Expense>>` - List of expenses in the category

#### getExpensesByDateRange(DateTime startDate, DateTime endDate)
Retrieves expenses within a date range.

**Parameters:**
- `startDate`: Start date (inclusive)
- `endDate`: End date (inclusive)

**Returns:** `Future<List<Expense>>` - List of expenses in the date range

#### updateExpense(Expense expense)
Updates an existing expense.

**Parameters:**
- `expense`: Expense object with updated data (must have valid ID)

**Returns:** `Future<int>` - Number of rows affected

#### deleteExpense(int id)
Deletes an expense by ID.

**Parameters:**
- `id`: ID of the expense to delete

**Returns:** `Future<int>` - Number of rows affected

### Category Operations

#### getAllCategories()
Retrieves all expense categories.

**Returns:** `Future<List<ExpenseCategory>>` - List of all categories

#### insertCategory(ExpenseCategory category)
Inserts a new category.

**Parameters:**
- `category`: ExpenseCategory object to insert

**Returns:** `Future<int>` - The ID of the inserted category

#### updateCategory(ExpenseCategory category)
Updates an existing category.

**Parameters:**
- `category`: ExpenseCategory object with updated data (must have valid ID)

**Returns:** `Future<int>` - Number of rows affected

#### deleteCategory(int id)
Deletes a category by ID.

**Parameters:**
- `id`: ID of the category to delete

**Returns:** `Future<int>` - Number of rows affected

### Analytics Operations

#### getTotalExpensesForMonth(DateTime month)
Calculates total expenses for a specific month.

**Parameters:**
- `month`: DateTime representing the month

**Returns:** `Future<double>` - Total amount spent in the month

#### getExpensesByCategoryForMonth(DateTime month)
Gets expense totals grouped by category for a specific month.

**Parameters:**
- `month`: DateTime representing the month

**Returns:** `Future<Map<String, double>>` - Map of category names to total amounts

**Example:**
```dart
DateTime currentMonth = DateTime.now();
double total = await DatabaseService.getTotalExpensesForMonth(currentMonth);
Map<String, double> categoryTotals = await DatabaseService.getExpensesByCategoryForMonth(currentMonth);
```

### Database Management

#### close()
Closes the database connection.

**Returns:** `Future<void>`

**Note:** This is automatically handled by the SQLite plugin, but can be called manually for cleanup.

## Models

### Expense Model

```dart
class Expense {
  final int? id;
  final String title;
  final String description;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;
}
```

**Methods:**
- `toMap()`: Convert to Map for database storage
- `fromMap(Map<String, dynamic> map)`: Create from database Map
- `copyWith()`: Create a copy with modified fields

### ExpenseCategory Model

```dart
class ExpenseCategory {
  final int? id;
  final String name;
  final String icon;
  final String color;
  final double? budgetLimit;
}
```

**Methods:**
- `toMap()`: Convert to Map for database storage
- `fromMap(Map<String, dynamic> map)`: Create from database Map
- `getDefaultCategories()`: Static method returning default categories

## Error Handling

All database operations may throw SQLite exceptions. Wrap calls in try-catch blocks:

```dart
try {
  await DatabaseService.insertExpense(expense);
  // Success
} catch (e) {
  // Handle error
  print('Database error: $e');
}
```

## Performance Considerations

- Database operations are asynchronous and should be awaited
- Large datasets are handled efficiently with indexed queries
- Use date range queries for better performance with large expense lists
- The database uses WAL mode for better concurrent access