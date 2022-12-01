import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watchnext/res/app_colors.dart';

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
