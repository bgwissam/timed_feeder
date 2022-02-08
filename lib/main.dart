import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timed_feeder/presentation/blocs/auth_bloc_bloc.dart';
import 'package:timed_feeder/presentation/blocs/simple_bloc_observer.dart';
import 'package:timed_feeder/presentation/screens/home_screen.dart';
import 'package:timed_feeder/presentation/screens/login_screen.dart';
import 'package:timed_feeder/presentation/screens/splash_screen.dart';

import 'domain/repositories/user_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepo _userRepo = UserRepo();
  late AuthBlocBloc _authBlocBloc;

  @override
  void initState() {
    _authBlocBloc = AuthBlocBloc(userRepo: _userRepo);
    _authBlocBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authBlocBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => _authBlocBloc,
        child: BlocBuilder<AuthBlocBloc, AuthBlocState>(
          builder: (context, state) {
            print('the state: $state');
            if (state is Uninitilized) {
              return const SplashScreen();
            }
            if (state is Autheniticated) {
              return const HomeScreen(
                title: 'DashBoard',
              );
            }
            if (state is UnAuthenticated) {
              return LoginInScreen(
                title: 'Sign In',
                userRepo: _userRepo,
              );
            }
            return const Center(child: Text('Unresolved error, contact admin'));
          },
        ),
      ),
    );
  }
}
