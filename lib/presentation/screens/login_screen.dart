import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';
import 'package:timed_feeder/fixed/constants.dart';
import 'package:timed_feeder/fixed/text_styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:timed_feeder/presentation/blocs/bloc/login_bloc.dart';

class LoginInScreen extends StatefulWidget {
  final title;
  UserRepo userRepo;
  LoginInScreen({Key? key, this.title, required this.userRepo})
      : super(key: key);

  @override
  _LoginInScreenState createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  late LoginBloc _loginBloc;
  UserRepo get _userRepo => widget.userRepo;
  var size;
  final _formKey = GlobalKey<FormState>();
  final Constants _constants = Constants();
  late String emailAddress;
  late String password;
  bool _obsecure = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepo: _userRepo);
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.yellow[700],
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => _loginBloc,
          child: _buildSignInForm(),
        ));
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //A logo for the app will be placed here
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 40),
              child: SizedBox(
                  height: size.height / 3,
                  child: Image.asset('assets/images/baby_bottle.jpeg')),
            ),
            //email address that will be used to login
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  filled: true,
                  labelText: _constants.emailAddress,
                  fillColor: Colors.grey[100],
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Email Address cannot be empty';
                  }
                  if (!EmailValidator.validate(val)) {
                    return 'Email is not valid';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    emailAddress = val.trim();
                  });
                },
              ),
            ),
            //password that will be used to login
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                initialValue: '',
                obscureText: _obsecure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obsecure = !_obsecure;
                      });
                    },
                    icon: Icon(
                        !_obsecure ? Icons.visibility : Icons.visibility_off),
                  ),
                  filled: true,
                  labelText: _constants.password,
                  fillColor: Colors.grey[100],
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  if (val.length < 6) {
                    return 'Password is too shot';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    password = val.trim();
                  });
                },
              ),
            ),
            //submit button
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(_constants.signIn),
                ),
              ),
            ),

            //forgot password button
            InkWell(
              onTap: () {
                //will take you to a forget my password page
                print('you are being taken right now');
              },
              child: Text(
                _constants.forgotPassword,
                style: textStyle1,
              ),
            )
          ],
        ),
      )),
    );
  }
}
