
import 'package:BTechApp_Final_Project/presentation/login/cubit/state.dart';
import 'package:BTechApp_Final_Project/repository/login_repository.dart';
import 'package:bloc/bloc.dart';


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
  void performLogout() {
    emit(LoginInitial());
  }
}

