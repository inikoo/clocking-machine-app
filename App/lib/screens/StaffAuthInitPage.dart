import 'package:ClockIN/Animation/FadeAnimation.dart';
import 'package:ClockIN/blocs/staff_auth_init_bloc/staff_auth_init_bloc.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:ClockIN/model/StaffAuthModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffAuthInitPage extends StatelessWidget {
  final bool nfc;
  final Staff staff;
  final String deviceName;

  StaffAuthInitPage({
    this.nfc = true,
    @required this.staff,
    @required this.deviceName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffAuthInitBloc()
        ..add(nfc
            ? InitialNfcEvent(staff: staff, deviceName: deviceName)
            : InitialPinCodeEvent(staff: staff, deviceName: deviceName)),
      child: _StaffAuthInitPageWidget(),
    );
  }
}

class _StaffAuthInitPageWidget extends StatefulWidget {
  @override
  __StaffAuthInitPageWidgetState createState() =>
      __StaffAuthInitPageWidgetState();
}

class __StaffAuthInitPageWidgetState extends State<_StaffAuthInitPageWidget>
    with StaffAuthModel {
  StaffAuthInitBloc _staffAuthInitBloc;

  @override
  void initState() {
    authContext = context;
    _staffAuthInitBloc = BlocProvider.of<StaffAuthInitBloc>(context);
    super.initState();
  }

  void _onPressedSendPinCode() {
    if (pincodeFromKey.currentState.validate()) {
      _staffAuthInitBloc.add(SetPinCodeEvent(txtPinCode.text));
    }
  }

  void _onPressedConfirmData() {
    _staffAuthInitBloc.add(ConfirmDataEvent());
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
                      child: BlocBuilder<StaffAuthInitBloc, StaffAuthInitState>(
                        builder: (context, state) {
                          if (state is ScanningNfcState) {
                            return scanningNfcWidget();
                          } else if (state is ShowPinCodeEntryState) {
                            return showPinCodeEntryWidget(
                                _onPressedSendPinCode);
                          } else if (state is PreviewDataState) {
                            return previewDataWidget(
                              nfc: state.nfc,
                              data: state.data,
                              staff: state.staff,
                              onPressedConfirmData: _onPressedConfirmData,
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
