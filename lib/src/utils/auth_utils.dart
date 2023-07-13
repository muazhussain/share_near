import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  String? email;
  String? password;
  double? latitude;
  double? longitude;

  Future<void> saveUserData(String userEmail, String userPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', userEmail);
    await prefs.setString('password', userPassword);
    email = userEmail;
    password = userPassword;
  }

  Future<bool> checkAuthState() async {
    return email == null || password == null;
  }

  Future<void> getAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    password = prefs.getString('password');
  }

  Future<void> saveLocation(double lat, double lon) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', lat);
    await prefs.setDouble('longitude', lon);
    latitude = lat;
    longitude = lon;
  }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
