import 'package:flutter/material.dart';

class LoginInScreen extends StatefulWidget {
  final title;
  const LoginInScreen({Key? key, this.title}) : super(key: key);

  @override
  _LoginInScreenState createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildSignInForm());
  }

  Widget _buildSignInForm() {
    return SingleChildScrollView(
      child: Center(
        child: Text('Login in please'),
      ),
    );
  }
}
