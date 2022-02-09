import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';
import 'package:timed_feeder/fixed/constants.dart';
import 'package:timed_feeder/fixed/text_styles.dart';
import 'package:timed_feeder/presentation/blocs/auth_bloc_bloc.dart';
import 'package:timed_feeder/presentation/blocs/bloc/register_bloc.dart';
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
  SnackBarWidget _snackBarWidget = SnackBarWidget();
  late RegisterBloc _registerBloc;

  final _formKey = GlobalKey<FormState>();
  UserRepo get _userRepo => widget.userRepo;
  final Constants _constants = Constants();
  bool _obsecure = true;
  var size;
  @override
  void initState() {
    super.initState();

    _registerBloc = RegisterBloc(userRepo: widget.userRepo);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _registerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _snackBarWidget.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(_constants.register),
        backgroundColor: Colors.yellow[700],
      ),
      body: BlocProvider(
        create: (context) => _registerBloc,
        child: _buildRegistrationForm(),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (context, state) {
        print('the current state: $state');
        if (state.isFailure) {
          _snackBarWidget.content = 'Failed to register';
          _snackBarWidget.showSnack();
        }
        if (state.isSubmitting) {
          _snackBarWidget.content = 'Regestering...';
          _snackBarWidget.showSnack();
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBlocBloc>(context).add(LoggedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        return state.isEmailValid != null &&
                                !state.isEmailValid!
                            ? 'Invalid Email'
                            : null;
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
                        return state.isPasswordValid != null &&
                                !state.isPasswordValid!
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _onFormSubmitted();
                          }
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
      ),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }

  Future<void> _onFormSubmitted() async {
    _registerBloc.add(Submitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
