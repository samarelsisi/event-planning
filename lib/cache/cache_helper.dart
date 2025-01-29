import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Save onboarding eligibility
  static Future<bool> saveEligibility() async {
    return await prefs.setBool('onBoarding', true);
  }

  // Retrieve onboarding eligibility
  static bool? getEligibility() {
    return prefs.getBool('onBoarding');
  }
}
