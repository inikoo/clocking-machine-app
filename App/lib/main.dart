import 'package:ClockIN/model/Loading.dart';
import 'package:ClockIN/screens/HomePage.dart';
import 'package:ClockIN/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ClockIN/screens/LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]).then(
    (_) => runApp(
      BlocProvider(
        create: (context) => AuthBloc()..add(CheckAuthEvent()),
        child: MaterialApp(
          title: "ClockIN",
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is HomePageAuthState) {
          return HomePage(user: state.user);
        } else if (state is LoginPageAuthState) {
          return LoginPage(errorText: state.error);
        }

        return Loading();
      },
    );
  }
}
