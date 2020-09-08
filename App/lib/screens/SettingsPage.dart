import 'package:ClockIN/blocs/staff_bloc/staff_bloc.dart';
import 'package:ClockIN/model/UpdateStaff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class SettingsPage extends StatelessWidget {
  final deviceName;

  SettingsPage({this.deviceName});

  Widget tabsContent(String caption, {String description = ''}) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(
            height: 20,
            color: Colors.black45,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          BlocProvider(
            create: (context) =>
                StaffBloc()..add(LoadStaffEvent(deviceName: deviceName)),
            child: Expanded(
              child: VerticalTabs(
                indicatorColor: Colors.blue,
                selectedTabBackgroundColor: Colors.black,
                backgroundColor: Colors.black,
                tabBackgroundColor: Color(0xFF323232),
                contentScrollAxis: Axis.vertical,
                tabsShadowColor: Colors.black,
                tabsWidth: 200,
                tabs: <Tab>[
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Update Staff NFC',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Update Staff Pin Code',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
                contents: <Widget>[
                  UpdateStaff(deviceName: deviceName, nfc: true),
                  UpdateStaff(deviceName: deviceName, nfc: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
