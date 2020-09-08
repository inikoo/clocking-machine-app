class User {
  // int id;
  // String username;
  // String email;
  // String name;
  String deviceName;
  // String token;

  User({
    // this.id,
    // this.username,
    // this.email,
    // this.name,
    this.deviceName,
    // this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      // "id": id ?? 0,
      // "username": username ?? "",
      // "email": email ?? "",
      // "name": name ?? "",
      "deviceName": deviceName ?? "",
      // "token": token ?? "",
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      // id: int.parse(map["id"].toString()) ?? 0,
      // username: map["username"].toString() ?? "",
      // email: map["email"].toString() ?? 0,
      // name: map["name"].toString() ?? "",
      deviceName: map["deviceName"].toString() ?? "",
      // token: map["token"].toString() ?? "",
    );
  }
}
