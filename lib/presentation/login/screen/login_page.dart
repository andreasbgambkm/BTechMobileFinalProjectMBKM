import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/login/cubit/state.dart';
import 'package:BTechApp_Final_Project/repository/EmployeeRepository.dart';

import 'package:BTechApp_Final_Project/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/presentation/login/cubit/cubit.dart';

class LoginView extends StatefulWidget {
  static String routeName = "/login";
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgaColor.bgaBodyColor,

      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1 ),
                    child: Image.asset('assets/images/logo_bga.png', scale: 1.5,),
                  ),
                  const SizedBox(height: 5.0,),
                  Text('BTech Mobile',
                      textAlign: TextAlign.center,
                      style: BgaTextStyle.loginTitleBold),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  BlocConsumer<LoginCubit, LoginState>(

                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(content: Text('Login Success')),
                          );
                        // Navigate to home page
                        Navigator.pushReplacementNamed(context, '/home',
                            arguments: state.loginData.user);
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        // Show error message

                        print(state.error);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is LoginLoading) ...[
                              const CircularProgressIndicator(),
                              SizedBox( height: MediaQuery.of(context).size.height * 0.03),
                            ],
                            TextFormField(

                              controller: _usernameController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Username Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Colors.orange),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  prefixIcon: CustomIconRectangle(icon: Icons.person_2_outlined),
                                  labelText: 'Username',
                                  labelStyle: BgaTextStyle.loginInputText,
                                  hintText: 'Enter your username',
                                  hintStyle: BgaTextStyle.loginInputText
                              ),
                            ),
                            SizedBox( height: MediaQuery.of(context).size.height * 0.03),
                            TextFormField(
                              controller: _passwordController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Password Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:  BorderSide(width: 3, color: BgaColor.bgaOrange),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: CustomIconRectangle(icon: Icons.lock),
                                labelText: 'Password',
                                labelStyle: BgaTextStyle.loginInputText,
                                hintText: 'Enter your password',
                                hintStyle: BgaTextStyle.loginInputText,
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                            BgaButton(
                              text: 'Login',

                              backgroundColor: BgaColor.bgaOrange,
                              onPressed: () async {
                               //await EmployeeRepository().insertCheckIn('001', 'Mr 456876', 1, DateTime.now().toString());
                                final username = _usernameController.text;
                                final password = _passwordController.text;
                              context.read<LoginCubit>().performLogin(username, password);
                              },
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
