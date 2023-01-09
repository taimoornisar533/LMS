import 'package:flutter/material.dart';
import 'package:mobile_final/Pages/Login.dart';
import 'package:mobile_final/Pages/SignUp.dart';
class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? Login(onClickedRegister: toggle,) : SignUp(onClickedLogin: toggle,);
  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}
