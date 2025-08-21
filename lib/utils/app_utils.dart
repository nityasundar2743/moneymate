import 'package:intl/intl.dart';

/// Utility functions for the MoneyMate app
class AppUtils {
  /// Format currency amount
  static String formatCurrency(double amount, {String symbol = '£'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Format date for display
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date and time for display
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  /// Format date for month view
  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  /// Get color from hex string
  static int colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return int.parse(buffer.toString(), radix: 16);
  }

  /// Get first day of month
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get last day of month
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Get current month start and end
  static Map<String, DateTime> getCurrentMonthRange() {
    final now = DateTime.now();
    return {
      'start': getFirstDayOfMonth(now),
      'end': getLastDayOfMonth(now),
    };
  }

  /// Calculate percentage
  static double calculatePercentage(double part, double total) {
    if (total == 0) return 0;
    return (part / total) * 100;
  }

  /// Validate if string is a valid number
  static bool isValidNumber(String value) {
    if (value.isEmpty) return false;
    return double.tryParse(value) != null;
  }

  /// Format percentage
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }
}