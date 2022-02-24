import 'package:intl/intl.dart';

class AppDateUtils {
  static formatDate(String? date) {
    String formatedDate = "";
    if (date != null) {
      var convertedDate = DateTime.tryParse(date);
      if (convertedDate != null) {
        formatedDate = DateFormat.yMMMMd("en_US").format(convertedDate);
      }
    }
    return formatedDate;
  }
}
