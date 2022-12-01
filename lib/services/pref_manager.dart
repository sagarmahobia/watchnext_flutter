import 'package:age_calculator/age_calculator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PrefsManager {
  final String _birthday = "BIRTHDAY";

  final SharedPreferences prefs;

  PrefsManager(this.prefs);

  saveBirthday(double? age) {
    if (age != null) {
      prefs.setDouble(_birthday, age);
    }
  }

  int? getBirthDay() {
    return prefs.getDouble(_birthday)?.toInt();
  }

  bool hasBirthday() {
    return true;

    return prefs.getDouble(_birthday) != null;
  }

  bool isAdult() {
    return true;

    if (!hasBirthday()) {
      return false;
    } else {
      var birthDate = DateTime.fromMillisecondsSinceEpoch(getBirthDay() ?? 0);

      var age = AgeCalculator.age(birthDate);

      if (age.years >= 18) {
        return true;
      } else {
        return false;
      }
    }
  }
}
