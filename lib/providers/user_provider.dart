import 'package:flutter/cupertino.dart';
import 'package:fresp/models/login_credentials.dart';
import 'package:fresp/models/user.dart';

class UserProvider with ChangeNotifier {
  LoginCredentials _user =
      LoginCredentials(email: '', token: '', isAdmin: false);
  LoginCredentials get user => _user;
  void setUser(String user) {
    print(user);
    _user = LoginCredentials.fromJson(user);

    notifyListeners();
  }
}
