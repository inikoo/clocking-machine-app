import 'package:ClockIN/blocs/staff_bloc/staff_bloc.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff list"),
      ),
      body: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          if (state is StaffLoadedEmpty) {
            return Container(
              child: Center(
                child: Text("Empty"),
              ),
            );
          } else if (state is StaffLoaded) {
            return ListView.builder(
              itemCount: state.staffs.length,
              itemBuilder: (context, index) {
                Staff _staff = state.staffs[index];

                return ListTile(
                  leading: Text(_staff.id.toString()),
                  title: Text(
                    _staff.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("NFC: ${_staff.nfc}"),
                );
              },
            );
          }

          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
