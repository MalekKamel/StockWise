import 'package:intl/intl.dart';

enum AppDateFormat {
  yyyyMMdd,
}

extension AppDateFormatExtension on AppDateFormat {
  String get formatString {
    switch (this) {
      case AppDateFormat.yyyyMMdd:
        return 'yyyy-MM-dd';
      default:
        return 'yyyy-MM-dd';
    }
  }
}

class AppDate {
  static String format(DateTime date,
      {AppDateFormat format = AppDateFormat.yyyyMMdd}) {
    final formatter = DateFormat(format.formatString);
    return formatter.format(date);
  }
}
