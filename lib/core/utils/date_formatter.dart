import 'package:intl/intl.dart';

class AppDateFormatter {
  const AppDateFormatter._();

  static String format(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isPast(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    return date.isBefore(normalizedToday);
  }
}
