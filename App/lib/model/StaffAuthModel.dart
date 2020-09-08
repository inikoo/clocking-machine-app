import 'package:ClockIN/data/staff/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

mixin StaffAuthModel {
  BuildContext authContext;
  final pincodeFromKey = GlobalKey<FormState>();
  final settingPinFromKey = GlobalKey<FormState>();
  TextEditingController txtPinCode = TextEditingController();
  TextEditingController txtSettingPin = TextEditingController();

  void onPressedCancel() {
    Navigator.pop(authContext);
  }

  String _validatePinCode(String value) {
    if (value == null || value.trim() == "" || value.length != 4) {
      return "PIN CODE must be 4 digits";
    }

    return null;
  }

  String _validateSettingPin(String value){
    if (value == null || value.trim() == "" || value.length != 6) {
      return "PIN must be 6 digits";
    }

    return null;
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPouringHourglass(
            color: Colors.black.withOpacity(0.5),
            size: 50.0,
          ),
          SizedBox(height: 20),
          Text(
            "Please wait",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget customizedButton(String title, Function onPressed) {
    return SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        color: Colors.transparent,
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
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
    );
  }

  Widget scanningNfcWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/scan_image.gif",
          height: 150,
        ),
        Text(
          "Scanning...",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Make sure to keep the NFC tag\nnear the phone.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: RaisedButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onPressed: onPressedCancel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.redAccent, width: 1.5),
              ),
              color: Colors.white,
              splashColor: Colors.redAccent,
            ),
          ),
        )
      ],
    );
  }

  Widget showMessageWidget(bool error, String message) {
    final icon = error ? Icons.error : Icons.check_circle;
    final color = error ? Colors.redAccent : Colors.greenAccent;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 50,
        ),
        SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        RaisedButton(
          child: Text(
            "Go back",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onPressed: onPressedCancel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: color, width: 1.5),
          ),
          color: Colors.white,
          splashColor: color,
        ),
      ],
    );
  }

  Widget showSelectActionWidget({
    @required Staff staff,
    @required Function onPressedInAction,
    @required Function onPressedOutAction,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your NFC detected!",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Name: ${staff.name}\nID: ${staff.nfc}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              "Select a Option:",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(height: 10),
        customizedButton("IN", onPressedInAction),
        SizedBox(height: 10),
        customizedButton("OUT", onPressedOutAction),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              child: Text(
                "Go back",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              onPressed: onPressedCancel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black.withOpacity(0.6),
                  width: 1.5,
                ),
              ),
              color: Colors.white,
              splashColor: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget showPinCodeEntryWidget(Function onPressedSendPinCode) {
    return Form(
      key: pincodeFromKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "PIN CODE",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TextFormField(
                controller: txtPinCode,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.black, width: 4),
                  ),
                  counterText: "",
                  hintText: "PIN CODE HERE",
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),
                validator: _validatePinCode,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  letterSpacing: 40,
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 4,
                maxLines: 1,
                maxLengthEnforced: true,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 85),
              child: customizedButton("SEND", onPressedSendPinCode),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: RaisedButton(
                  child: Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  onPressed: onPressedCancel,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.6), width: 1.5),
                  ),
                  color: Colors.white,
                  splashColor: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSettingPinEntryWidget(Function onPressedAuth) {
    return Form(
      key: settingPinFromKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TextFormField(
                controller: txtSettingPin,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.black, width: 4),
                  ),
                  counterText: "",
                  hintText: "ADMIN PIN HERE",
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),
                validator: _validateSettingPin,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  letterSpacing: 40,
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 6,
                maxLines: 1,
                maxLengthEnforced: true,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 85),
              child: customizedButton("Authenticate", onPressedAuth),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: RaisedButton(
                  child: Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  onPressed: onPressedCancel,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.6), width: 1.5),
                  ),
                  color: Colors.white,
                  splashColor: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customizedButton2({
    String title,
    Function onPressed,
    bool cancel = false,
  }) {
    return SizedBox(
      height: 50,
      width: 200,
      child: RaisedButton(
        color: Colors.transparent,
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: cancel
                  ? [
                      Color(0xFFBDCABA),
                      Color(0xFFBDCABA),
                    ]
                  : [
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
    );
  }

  Widget previewDataWidget({
    bool nfc,
    String data,
    Staff staff,
    Function onPressedConfirmData,
  }) {
    String _value = nfc ? "NFC: " : "Pin code: ";
    _value += data;

    String _message = "Confirm if you want to assign this ";
    _message += nfc ? "NFC " : "Pin code ";
    _message += "to ${staff.name}.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nfc
            ? Text(
                "NFC detected!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              )
            : SizedBox.shrink(),
        SizedBox(height: 10),
        Text(
          _message,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black.withOpacity(0.5),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20),
        Text(
          _value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customizedButton2(
              title: "Confirm",
              onPressed: onPressedConfirmData,
            ),
            SizedBox(width: 10),
            customizedButton2(
              title: "Cancel",
              onPressed: onPressedCancel,
              cancel: true,
            ),
          ],
        ),
      ],
    );
  }
}
