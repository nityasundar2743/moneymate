/// Expense model representing individual expense transactions
class Expense {
  final int? id;
  final String title;
  final String description;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;

  const Expense({
    this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  /// Convert Expense to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  /// Create Expense from Map (database retrieval)
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }

  /// Create a copy of this expense with modified fields
  Expense copyWith({
    int? id,
    String? title,
    String? description,
    double? amount,
    String? category,
    DateTime? date,
    String? notes,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}