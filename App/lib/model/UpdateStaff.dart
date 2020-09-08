import 'package:ClockIN/data/staff/staff.dart';
import 'package:ClockIN/model/StaffList.dart';
import 'package:ClockIN/screens/StaffAuthInitPage.dart';
import 'package:flutter/material.dart';

class UpdateStaff extends StatelessWidget {
  final bool nfc;
  final String deviceName;

  UpdateStaff({@required this.nfc, @required this.deviceName});

  void _onPressedStaffRow(Staff staff, BuildContext context) {
    print(staff.id);
    print(staff.name);
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => StaffAuthInitPage(
          nfc: nfc,
          staff: staff,
          deviceName: deviceName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            Text(
              nfc ? "Update Staff NFC" : "Update Staff Pin Code",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select the staff you want to update",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StaffList(_onPressedStaffRow),
            ),
          ],
        ),
      ),
    );
  }
}
