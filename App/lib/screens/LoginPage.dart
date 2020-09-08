import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClockIN/Animation/FadeAnimation.dart';
import 'package:ClockIN/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  final String errorText;
  LoginPage({this.errorText = ""});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _checkServerAddress = true;
  // bool _checkUsername = true;
  // bool _checkPassword = true;
  bool _checkDeviceName = true;

  // final TextEditingController _serverAddressController =
  //     TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _deviceNameController = TextEditingController();

  void _onPressedLogin(BuildContext context) {
    setState(() {
      // _checkServerAddress = (_serverAddressController.text != null &&
      //     _serverAddressController.text != "");
      // _checkUsername =
      //     (_usernameController.text != null && _usernameController.text != "");
      // _checkPassword =
      //     (_passwordController.text != null && _passwordController.text != "");
      _checkDeviceName = (_deviceNameController.text != null &&
          _deviceNameController.text != "");
    });

    if (_checkDeviceName) {
      BlocProvider.of<AuthBloc>(context).add(LoginAuthEvent(
        // username: _usernameController.text,
        // password: _passwordController.text,
        deviceName: _deviceNameController.text,
      ));
    }
  }

  Widget _customizedTextFiled({
    @required String hintText,
    @required IconData prefixIcon,
    @required TextEditingController textEditingController,
    @required bool state,
    bool password = false,
  }) {
    double _borderRadius = 5.0;
    double _textPadding = 20.0;
    double _iconSize = 20.0;
    double _iconBoxSize = 60.0;
    Color _iconColor = Color(0xFF5F6269);
    Color _iconErrorColor = Colors.redAccent;
    Color _iconBackgroundColor = Color(0xFF373A41);
    Color _textBoxColor = Colors.white;
    double _textBoxWidth = 400.0;
    EdgeInsets _textContentPadding =
        EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0);
    double _fontSize = 18;

    return Container(
      width: _textBoxWidth,
      decoration: BoxDecoration(
        color: _textBoxColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: TextFormField(
        expands: false,
        controller: textEditingController,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: _textPadding),
            child: SizedBox(
              width: _iconBoxSize,
              height: _iconBoxSize,
              child: Container(
                decoration: BoxDecoration(
                  color: _iconBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                  ),
                  border: Border.all(color: _iconBackgroundColor),
                ),
                child: Icon(
                  prefixIcon,
                  color: state ? _iconColor : _iconErrorColor,
                  size: _iconSize,
                ),
              ),
            ),
          ),
          contentPadding: _textContentPadding,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
        obscureText: password,
        style: TextStyle(
          fontSize: _fontSize,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/images/login_background.jpg"),
              //   fit: BoxFit.cover,
              // ),
              color: Colors.black,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      1.3,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                          Text(
                            "aurora",
                            style: TextStyle(
                              fontSize: 40,
                              color: Color(0xFFDC7300),
                              fontFamily: "Calibri",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    FadeAnimation(
                      1.8,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // _customizedTextFiled(
                          //   hintText: "Server Address",
                          //   prefixIcon: FontAwesome5Solid.desktop,
                          //   textEditingController: _serverAddressController,
                          //   state: _checkServerAddress,
                          // ),
                          // SizedBox(height: 15),
                          // _customizedTextFiled(
                          //   hintText: "User Name",
                          //   prefixIcon: FontAwesome.user,
                          //   textEditingController: _usernameController,
                          //   state: _checkUsername,
                          // ),
                          // SizedBox(height: 15),
                          // _customizedTextFiled(
                          //   hintText: "Password",
                          //   prefixIcon: FontAwesome.lock,
                          //   textEditingController: _passwordController,
                          //   state: _checkPassword,
                          //   password: true,
                          // ),
                          // SizedBox(height: 15),
                          _customizedTextFiled(
                            hintText: "Device Name",
                            prefixIcon: AntDesign.mobile1,
                            textEditingController: _deviceNameController,
                            state: _checkDeviceName,
                            password: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    (this.widget.errorText != null &&
                            this.widget.errorText != "")
                        ? FadeAnimation(
                            0.3,
                            Column(
                              children: [
                                Text(
                                  widget.errorText,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    FadeAnimation(
                      2,
                      RaisedButton(
                        onPressed: () => _onPressedLogin(context),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.all(0.0),
                        splashColor: Colors.black.withOpacity(0.8),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color(0xFFDC7300),
                            // color: Color(0xFF171717),
                            border: Border.all(color: Color(0xFF171717)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 60.0,
                              maxWidth: 400,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'LOG IN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
