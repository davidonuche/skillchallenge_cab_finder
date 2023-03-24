import 'dart:ui';

class Constants {
  static const String appName = 'My Ride App';
  static const String apiBaseUrl = 'https://api.myrideapp.com';
  static const int maxRideDuration = 24; // in hours

  // Colors
  static const Color primaryColor = Color(0xFF1565C0);
  static const Color accentColor = Color(0xFF64B5F6);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Text styles
  static TextStyle headingTextStyle =  TextStyle(fontSize: 24, fontWeight: FontWeight.bold,);
  static TextStyle subheadingTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold,);
  static TextStyle bodyTextStyle = TextStyle(fontSize: 16,);
}
