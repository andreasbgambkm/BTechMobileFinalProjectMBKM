import 'dart:convert';
import 'package:flutter/services.dart';

class LoginModel {
  final String nik;
  final String username;
  final String password;
  final String name;
  final String position;
  final String division;

  LoginModel({
    required this.nik,
    required this.username,
    required this.password,
    required this.name,
    required this.position,
    required this.division,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      nik: json['nik'],
      username: json['username'] ,
      password: json['password'],
      name: json['name'],
      position: json['position'],
      division: json['division'],
    );
  }




}
