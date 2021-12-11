import 'package:flutter/foundation.dart';
import 'package:towghana/model/user.dart';

class UserProvider with ChangeNotifier {
  User _user = new User(
      userId: '', email: '', firstname: '', lastname: '', phoneNumber: '');

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
