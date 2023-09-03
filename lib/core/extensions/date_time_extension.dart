import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static const dateFormat1 = "dd/MM/yyyy";
  static const dateFormat2 = "yyyy-MM-dd";
  static const dateFormat3 = "dd / MM / yyyy";
  static const dateFormat4 = "dd/MM/yy";
  static const dateFormat5 = "yyyy/MM/dd";
  static const dateFormat6 = "HH:mm dd/MM/yyyy";
  static const dateFormat7 = "HH:mm";
  String convertToString([String format = dateFormat1]) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String formatDateVietnamese() {
    return ((weekday + 1) < 7)
        ? "T${weekday + 1}, ${convertToString()}"
        : "CN, ${convertToString()}";
  }

  DateTime get onlyDate => copyWith(
        hour: 0,
        millisecond: 0,
        second: 0,
        minute: 0,
        microsecond: 0,
      );
}
