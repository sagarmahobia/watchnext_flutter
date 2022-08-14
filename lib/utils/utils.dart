//todo date format
// todo person detail image,kTra**
import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat formatter = DateFormat('MMM dd yyyy');

  static getPrettyDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    return formatter.format(date);
  }
}

extension MyDateTime on DateTime {

  String toPrettyDate(){
    return DateUtil.getPrettyDate(this);
  }

}