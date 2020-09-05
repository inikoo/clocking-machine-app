class StaffInOut {
  int id;
  int staffId;
  String timeIn;
  String timeOut;
  String imagePath;

  StaffInOut({
    this.id,
    this.staffId,
    this.timeIn,
    this.timeOut,
    this.imagePath,
  });

  static StaffInOut fromMap(Map<String, dynamic> map) {
    return StaffInOut(
      id: int.parse(map["id"].toString()) ?? 0,
      staffId: int.parse(map["staff_id"].toString()) ?? 0,
      timeIn: map["in"].toString() != "null" ? map["in"].toString() ?? "" : "",
      timeOut:
          map["out"].toString() != "null" ? map["out"].toString() ?? "" : "",
    );
  }
}
