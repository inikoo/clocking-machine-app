import 'package:ClockIN/Animation/FadeAnimation.dart';
import 'package:ClockIN/blocs/staff_bloc/staff_bloc.dart';
import 'package:ClockIN/data/staff/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffList extends StatelessWidget {
  final Function onPressedStaffRow;

  StaffList(this.onPressedStaffRow);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffBloc, StaffState>(
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

              return FadeAnimation(
                1,
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlatButton(
                      onPressed: () => onPressedStaffRow(_staff, context),
                      child: ListTile(
                        leading: Text(_staff.id.toString()),
                        title: Text(
                          _staff.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
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
    );
  }
}
