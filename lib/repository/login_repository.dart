import 'dart:convert';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:flutter/services.dart' show rootBundle;

class LoginRepository {
  // Future<LoginData> fetchLoginData() async {
  //   final jsonData =
  //   await rootBundle.loadString('assets/data/login_data.json');
  //   final loginDataJson = jsonDecode(jsonData);
  //
  //   return LoginData.fromJson(loginDataJson);
  // }

  //trial

   Future<LoginData> fetchLoginData(String username, String password) async {
    String data = await rootBundle.loadString('assets/data/login_data.json');
    List<dynamic> loginList = jsonDecode(data)['login'];
    for (final login in loginList) {
      if (login['username'] == username && login['password'] == password) {
        return LoginData.fromJson(login);
      }
    }
    throw Exception('Invalid username/password');
  }

}

