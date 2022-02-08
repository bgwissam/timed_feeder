import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';
import 'package:timed_feeder/fixed/constants.dart';
import 'package:timed_feeder/fixed/text_styles.dart';
import 'package:timed_feeder/presentation/blocs/auth_bloc_bloc.dart';
import 'package:timed_feeder/presentation/blocs/bloc/login_bloc.dart';
import 'package:timed_feeder/presentation/widgets/snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  final UserRepo userRepo;
  const RegistrationScreen({Key? key, required this.userRepo})
      : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SnackBarWidget _snackBarWidget;
  late LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();
  UserRepo get _userRepo => widget.userRepo;
  final Constants _constants = Constants();
  bool _obsecure = true;
  var size;
  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _snackBarWidget.context = context;
    return BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state.isFailure) {
            _snackBarWidget.content = 'Failed to Login';
            _snackBarWidget.showSnack();
          }
          if (state.isSubmitting) {
            _snackBarWidget.content = 'Logging in...';
            _snackBarWidget.showSnack();
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthBlocBloc>(context).add(LoggedIn());
          }
        },
        child: _buildRegistrationForm());
  }

  Widget _buildRegistrationForm() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
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
                    controller: _emailController,
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
                    validator: (_) {
                      return !state.isEmailValid! ? 'Invalid Email' : null;
                    },
                  ),
                ),
                //password that will be used to login
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecure,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                        icon: Icon(!_obsecure
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                    validator: (_) {
                      return !state.isPasswordValid!
                          ? 'Password not valid'
                          : null;
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
                      child: Text(_constants.register),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
