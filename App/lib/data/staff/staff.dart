import 'package:ClockIN/data/staff/staff_in_out.dart';

class Staff {
  int id;
  String name;
  String nfc;
  String pin;
  StaffInOut staffInOut;

  Staff({
    this.id,
    this.name,
    this.nfc,
    this.pin,
    this.staffInOut,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id ?? 0,
      "name": name ?? "",
      "nfc": nfc ?? "",
      "pin": pin ?? ""
    };
  }

  static Staff fromMap(Map<String, dynamic> map) {
    return Staff(
      id: int.parse(map["id"].toString()) ?? 0,
      name: map["name"].toString() ?? "",
      nfc: map["nfc"].toString() ?? "",
      pin: map["pin"].toString() ?? "",
      staffInOut: map["lastInOut"] != null
          ? StaffInOut.fromMap(map["lastInOut"]) ?? null
          : null,
    );
  }
}
