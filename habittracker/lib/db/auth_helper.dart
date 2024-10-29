import 'package:hive/hive.dart';

class AuthHelper {
  static final AuthHelper instance = AuthHelper._internal();
  AuthHelper._internal();

  Future<bool> loginUser(String username, String password) async {
    var box = await Hive.openBox('users');
    final storedPassword = box.get(username);

    if (storedPassword == password) {
      box.put('loggedInUser', username); // Save current logged-in user
      return true;
    }
    return false;
  }

  Future<void> logoutUser() async {
    var box = await Hive.openBox('users');
    await box.delete('loggedInUser'); // Remove the logged-in user data
  }

  Future<String?> getLoggedInUsername() async {
    var box = await Hive.openBox('users');
    return box.get('loggedInUser') as String?;
  }
  
  Future<bool> signupUser(String username, String password) async {
    var box = await Hive.openBox('users');
    if (box.containsKey(username)) return false;
    await box.put(username, password);
    return true;
  }
}
