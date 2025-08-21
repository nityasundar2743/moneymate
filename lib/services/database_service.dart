import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';
import '../models/expense_category.dart';

/// Database service for managing expenses and categories
class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'moneymate.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String expensesTable = 'expenses';
  static const String categoriesTable = 'categories';

  /// Get database instance (singleton pattern)
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  /// Create database tables
  static Future<void> _onCreate(Database db, int version) async {
    // Create expenses table
    await db.execute('''
      CREATE TABLE $expensesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        notes TEXT
      )
    ''');

    // Create categories table
    await db.execute('''
      CREATE TABLE $categoriesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        budgetLimit REAL
      )
    ''');

    // Insert default categories
    final defaultCategories = ExpenseCategory.getDefaultCategories();
    for (var category in defaultCategories) {
      await db.insert(categoriesTable, category.toMap());
    }
  }

  // EXPENSE CRUD OPERATIONS

  /// Insert a new expense
  static Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert(expensesTable, expense.toMap());
  }

  /// Get all expenses
  static Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      expensesTable,
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  /// Get expenses by category
  static Future<List<Expense>> getExpensesByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      expensesTable,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  /// Get expenses by date range
  static Future<List<Expense>> getExpensesByDateRange(
      DateTime startDate, DateTime endDate) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      expensesTable,
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'date DESC',
    );

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  /// Update an expense
  static Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update(
      expensesTable,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  /// Delete an expense
  static Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete(
      expensesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CATEGORY CRUD OPERATIONS

  /// Get all categories
  static Future<List<ExpenseCategory>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(categoriesTable);

    return List.generate(maps.length, (i) {
      return ExpenseCategory.fromMap(maps[i]);
    });
  }

  /// Insert a new category
  static Future<int> insertCategory(ExpenseCategory category) async {
    final db = await database;
    return await db.insert(categoriesTable, category.toMap());
  }

  /// Update a category
  static Future<int> updateCategory(ExpenseCategory category) async {
    final db = await database;
    return await db.update(
      categoriesTable,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  /// Delete a category
  static Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete(
      categoriesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ANALYTICS METHODS

  /// Get total expenses for a specific month
  static Future<double> getTotalExpensesForMonth(DateTime month) async {
    final db = await database;
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $expensesTable WHERE date BETWEEN ? AND ?',
      [startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
    );

    return result.first['total'] as double? ?? 0.0;
  }

  /// Get expense totals by category for a specific month
  static Future<Map<String, double>> getExpensesByCategoryForMonth(
      DateTime month) async {
    final db = await database;
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    final result = await db.rawQuery(
      'SELECT category, SUM(amount) as total FROM $expensesTable WHERE date BETWEEN ? AND ? GROUP BY category',
      [startOfMonth.toIso8601String(), endOfMonth.toIso8601String()],
    );

    Map<String, double> categoryTotals = {};
    for (var row in result) {
      categoryTotals[row['category'] as String] = row['total'] as double;
    }

    return categoryTotals;
  }

  /// Close database connection
  static Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}