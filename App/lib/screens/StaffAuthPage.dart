import 'package:ClockIN/blocs/staff_auth_bloc/staff_auth_bloc.dart';
import 'package:ClockIN/model/StaffAuthModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClockIN/Animation/FadeAnimation.dart';

class StaffAuthPage extends StatelessWidget {
  final bool manual;
  final String deviceName;

  StaffAuthPage({
    this.manual = false,
    @required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffAuthBloc()
        ..add(manual
            ? ManualAuthEvent(deviceName: deviceName)
            : ReadNfcEvent(deviceName: deviceName)),
      child: _StaffAuthPageWidget(),
    );
  }
}

class _StaffAuthPageWidget extends StatefulWidget {
  @override
  __StaffAuthPageWidgetState createState() => __StaffAuthPageWidgetState();
}

class __StaffAuthPageWidgetState extends State<_StaffAuthPageWidget>
    with StaffAuthModel {
  StaffAuthBloc _staffAuthBloc;

  @override
  void initState() {
    authContext = context;
    _staffAuthBloc = BlocProvider.of<StaffAuthBloc>(context);
    super.initState();
  }

  void _onPressedInAction() => _staffAuthBloc.add(InActionEvent());

  void _onPressedOutAction() => _staffAuthBloc.add(OutActionEvent());

  void _onPressedSendPinCode() {
    if (pincodeFromKey.currentState.validate()) {
      _staffAuthBloc.add(SetManualAuthEvent(txtPinCode.text));
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
                      child: BlocBuilder<StaffAuthBloc, StaffAuthState>(
                        builder: (context, state) {
                          if (state is ScanningNfcState) {
                            return scanningNfcWidget();
                          } else if (state is ShowManualAuthState) {
                            return showPinCodeEntryWidget(
                                _onPressedSendPinCode);
                          } else if (state is SelectActionState) {
                            return showSelectActionWidget(
                              staff: state.staff,
                              onPressedInAction: _onPressedInAction,
                              onPressedOutAction: _onPressedOutAction,
                            );
                          } else if (state is SuccessState) {
                            return showMessageWidget(false, state.message);
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
