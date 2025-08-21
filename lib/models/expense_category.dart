/// Expense category model for organizing expenses
class ExpenseCategory {
  final int? id;
  final String name;
  final String icon;
  final String color;
  final double? budgetLimit;

  const ExpenseCategory({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.budgetLimit,
  });

  /// Convert ExpenseCategory to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'budgetLimit': budgetLimit,
    };
  }

  /// Create ExpenseCategory from Map (database retrieval)
  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      color: map['color'],
      budgetLimit: map['budgetLimit'],
    );
  }

  /// Predefined expense categories
  static List<ExpenseCategory> getDefaultCategories() {
    return [
      ExpenseCategory(name: 'Food & Dining', icon: 'restaurant', color: 'FF4CAF50'),
      ExpenseCategory(name: 'Transportation', icon: 'directions_car', color: 'FF2196F3'),
      ExpenseCategory(name: 'Shopping', icon: 'shopping_bag', color: 'FFFF9800'),
      ExpenseCategory(name: 'Entertainment', icon: 'movie', color: 'FF9C27B0'),
      ExpenseCategory(name: 'Bills & Utilities', icon: 'receipt', color: 'FFF44336'),
      ExpenseCategory(name: 'Health & Medical', icon: 'local_hospital', color: 'FF00BCD4'),
      ExpenseCategory(name: 'Education', icon: 'school', color: 'FF673AB7'),
      ExpenseCategory(name: 'Travel', icon: 'flight', color: 'FF795548'),
      ExpenseCategory(name: 'Other', icon: 'category', color: 'FF607D8B'),
    ];
  }
}