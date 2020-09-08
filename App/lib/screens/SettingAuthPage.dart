import 'package:ClockIN/Animation/FadeAnimation.dart';
import 'package:ClockIN/blocs/setting_auth_bloc/setting_auth_bloc.dart';
import 'package:ClockIN/model/StaffAuthModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingAuthPage extends StatelessWidget {
  final String deviceName;

  SettingAuthPage({@required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingAuthBloc()..add(InitEvent(deviceName)),
      child: SettingAuthPageWidget(),
    );
  }
}

class SettingAuthPageWidget extends StatefulWidget {
  @override
  _SettingAuthPageWidgetState createState() => _SettingAuthPageWidgetState();
}

class _SettingAuthPageWidgetState extends State<SettingAuthPageWidget>
    with StaffAuthModel {
  SettingAuthBloc _settingAuthBloc;

  @override
  void initState() {
    authContext = context;
    _settingAuthBloc = BlocProvider.of<SettingAuthBloc>(context);
    super.initState();
  }

  void _onPressedAuth() {
    if (settingPinFromKey.currentState.validate()) {
      _settingAuthBloc.add(AuthEvent(txtSettingPin.text));
    }
  }

  Future<bool> _willPopCallback() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Stack(
          children: [
            FadeAnimation(
              0.2,
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 350,
                    width: double.infinity,
                    child: Center(
                      child: BlocBuilder<SettingAuthBloc, SettingAuthState>(
                        builder: (context, state) {
                          if (state is ShowAuthScreenState) {
                            return showSettingPinEntryWidget(_onPressedAuth);
                          } else if (state is SuccessState) {
                            Navigator.pop(context, true);
                          } else if (state is ErrorState) {
                            return showMessageWidget(true, state.message);
                          }

                          return loadingWidget();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
