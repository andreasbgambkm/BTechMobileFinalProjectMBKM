import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:equatable/equatable.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {

  final LoginData loginData;

  const LoginSuccess({required this.loginData});

  @override
  List<Object> get props => [loginData];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class Logout extends LoginState {} // State untuk logout

