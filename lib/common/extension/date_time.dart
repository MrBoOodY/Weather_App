import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String formatToTime({String? locale}) {
    return DateFormat('hh:mm aaa', locale).format(this);
  }

  String formatToDate({String? locale}) {
    return DateFormat('dd MMM yyyy', locale).format(this);
  }
}
