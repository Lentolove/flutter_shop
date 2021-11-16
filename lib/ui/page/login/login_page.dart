import 'package:flutter/material.dart';

///登录界面
class LoginPage extends StatelessWidget {

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  final TextEditingController _accountController = TextEditingController();

  final TextEditingController _passWordController = TextEditingController();


  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
