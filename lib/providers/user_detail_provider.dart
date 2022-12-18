import 'package:flutter/cupertino.dart';
import 'package:fresp/models/user.dart';

class UserDetailProvider with ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      number: '',
      email: '',
      address: [],
      orderHistory: [],
      cart: []);
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
