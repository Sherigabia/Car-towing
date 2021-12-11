import 'package:shared_preferences/shared_preferences.dart';
import 'package:towghana/model/user.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId);
    prefs.setString("name", user.firstname);
    prefs.setString("name", user.lastname);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phoneNumber);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId")!;
    String firstname = prefs.getString("firstname")!;
    String lastname = prefs.getString("lastname")!;
    String email = prefs.getString("email")!;
    String phoneNumber = prefs.getString("phoneNumber")!;

    return User(
      userId: userId,
      firstname: firstname,
      lastname: lastname,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
