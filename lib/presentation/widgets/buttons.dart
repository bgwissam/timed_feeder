import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timed_feeder/domain/repositories/user_repo.dart';
import 'package:timed_feeder/fixed/constants.dart';
import 'package:timed_feeder/fixed/text_styles.dart';
import 'package:timed_feeder/presentation/blocs/bloc/login_bloc.dart';
import 'package:timed_feeder/presentation/screens/registration_screen.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context)
            .add(const LoginWithGooglePressed([]));
      },
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: Text(
        'Google',
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final UserRepo userRepo;

  RegisterButton({Key? key, required this.userRepo}) : super(key: key);

  final _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RegistrationScreen(userRepo: userRepo),
            ),
          );
        },
        child: Text(
          _constants.register,
          style: textStyle2,
        ));
  }
}
