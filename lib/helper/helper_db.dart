import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _profileImageKey = 'profileImagePath';

  // Get instance of SharedPreferences
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Save user data
  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
    String? profileImagePath,
  }) async {
    final prefs = await _getPrefs();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    if (profileImagePath != null) {
      await prefs.setString(_profileImageKey, profileImagePath);
    }
  }

  // Retrieve user data
  static Future<Map<String, String?>> getUser() async {
    final prefs = await _getPrefs();
    return {
      'username': prefs.getString(_usernameKey),
      'email': prefs.getString(_emailKey),
      'password': prefs.getString(_passwordKey),
      'profileImagePath': prefs.getString(_profileImageKey),
    };
  }

  // Check if user is logged in (e.g., email exists)
  static Future<bool> isLoggedIn() async {
    final prefs = await _getPrefs();
    return prefs.getString(_emailKey) != null;
  }

  // Clear user data (e.g., for logout)
  static Future<void> clearUser() async {
    final prefs = await _getPrefs();
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.remove(_profileImageKey);
  }
}
