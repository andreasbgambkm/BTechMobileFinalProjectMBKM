import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/data/repositories/login_repository.dart';
import 'package:BTechApp_Final_Project/presentation/features/auth/login/cubit/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());



  // method login
  Future<void> performLogin(String username, String password) async {

    if (username.isEmpty || password.isEmpty) {
      emit(LoginFailure(error: 'Username or password cannot be empty.'));
      return;
    }

    try {
      emit(LoginLoading());


      final loginRepository = LoginRepository();
      final loginData = await loginRepository.fetchLoginData(username, password);

      if (loginData.username == username && loginData.password == password) {


        emit(LoginSuccess(loginData: loginData));

      } else {
        emit(LoginFailure(error: 'Invalid username or password.'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  // method logout
  void performLogout(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Logout'),
            content: Text('Anda yakin ingin logout?'),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(BgaColor.bgaOrange),
                  foregroundColor: MaterialStateProperty.all<Color>(BgaColor.bgaWhiteA700),
                ),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: BgaColor.bgaWhiteA700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(BgaColor.bgaOrange),
                  foregroundColor: MaterialStateProperty.all<Color>(BgaColor.bgaWhiteA700),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: BgaColor.bgaWhiteA700,
                  ),
                ),
                onPressed: () async {
                  emit(LoginLoading());
                  // Melakukan logout dan kembali ke halaman login
                  emit(Logout());
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }

  }


