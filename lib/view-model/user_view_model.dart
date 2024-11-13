import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userviewmodel extends ChangeNotifier {
  int? logId;

  Future<void> loadLogId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? logIdString = prefs.getString('isLoggedIn') ?? '';

    logId = int.tryParse(logIdString!);
    notifyListeners();
  }
}
