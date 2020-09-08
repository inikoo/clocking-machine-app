import 'package:ClockIN/Animation/FadeAnimation.dart';
import 'package:ClockIN/blocs/auth_bloc/auth_bloc.dart';
import 'package:ClockIN/data/user/user.dart';
import 'package:ClockIN/model/HomeBackground.dart';
import 'package:ClockIN/screens/SettingAuthPage.dart';
import 'package:ClockIN/screens/SettingsPage.dart';
import 'package:ClockIN/screens/StaffAuthPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onPressedWithCard() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => StaffAuthPage(
          deviceName: widget.user.deviceName,
        ),
      ),
    );
  }

  void _onPressedWithoutCard() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => StaffAuthPage(
          manual: true,
          deviceName: widget.user.deviceName,
        ),
      ),
    );
  }

  Future<void> _onPressedSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingAuthPage(
          deviceName: widget.user.deviceName,
        ),
      ),
    );

    if (result != null && result == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SettingsPage(deviceName: widget.user.deviceName),
        ),
      );
    }
  }

  void _onPressedLogout() {
    _onPressedYes() {
      BlocProvider.of<AuthBloc>(context)..add(LogoutAuthEvent());
      Navigator.pop(context);
    }

    _onPressedNo() {
      Navigator.pop(context);
    }

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure want to logout?"),
      actions: [
        FlatButton(child: Text("Yes"), onPressed: _onPressedYes),
        FlatButton(child: Text("No"), onPressed: _onPressedNo),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _willPopCallback() async {
    return true;
  }

  Widget _customizedButton(String title, Function onPressed) {
    return FadeAnimation(
      2,
      SizedBox(
        height: 50,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                // color: Colors.grey.withOpacity(0.8),
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: RaisedButton(
            color: Colors.transparent,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(143, 163, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 50,
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.black),
            HomeBackground(),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _onPressedSettings,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _onPressedLogout,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _customizedButton('With Card', _onPressedWithCard),
                    SizedBox(
                      height: 30,
                    ),
                    _customizedButton('With Out Card', _onPressedWithoutCard),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
