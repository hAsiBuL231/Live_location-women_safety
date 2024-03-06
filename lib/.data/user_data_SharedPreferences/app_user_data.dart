import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../models/user_models.dart';


class shared_Preferences {
  Future<String> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  void saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }
}



class UserDataProvider extends ChangeNotifier {
  Users? _userData;

  Users? get userData => _userData;

  void saveUserData(Users data) {
    _userData = data;
    notifyListeners();
  }
}
