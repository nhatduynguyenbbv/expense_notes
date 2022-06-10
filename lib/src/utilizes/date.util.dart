import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String toDateString([String pattern = 'MMM d, yyyy']) {
    return DateFormat(pattern).format(this);
  }
}
