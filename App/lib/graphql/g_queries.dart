class GQueries {
  static String staffByRfid(String rfid) {
    return """
      query {
        staffByRfid(rfid: "$rfid"){
          id,
          name,
          rfid,
          pin_code,
          lastInOut {
            id,
            staff_id,
            in,
            out,
            image_path
          }
        }
      }
    """;
  }

  static String staffByPinCode(String pinCode) {
    return """
      query {
        staffByPinCode(pin_code: "$pinCode"){
          id,
          name,
          rfid,
          pin_code,
          lastInOut {
            id,
            staff_id,
            in,
            out,
            image_path
          }
        }
      }
    """;
  }

  static String loginUser({String username, String password}) {
    return """
      mutation {
        login(
          username: "$username",
          password: "$password"
        ) {
          id,
          username,
          email,
          name
        }
      }
    """;
  }

  static String setStaffInOut({
    String action,
    String time,
    int staffId,
    bool fileAvailable,
    String imageFileName,
  }) {
    return """
    mutation {
      setStaffInOut(
        action: "$action",
        time: "$time",
        staff_id: $staffId,
        file_available: $fileAvailable,
        image_file_name: "$imageFileName"
      ) {
        id,
        staff_id,
        in,
        out,
        image_path
      }
    }
  """;
  }

  static String setStaffInOutWithImage({
    String action,
    String time,
    int staffId,
    bool fileAvailable,
    String imageFileName,
  }) {
    return """
    mutation(\$image_file: Upload){
      setStaffInOut(
        action: "$action",
        time: "$time",
        staff_id: $staffId,
        image_file: \$image_file,
        file_available: $fileAvailable,
        image_file_name: "$imageFileName"
      ) {
        id,
        staff_id,
        in,
        out,
        image_path
      }
    }
  """;
  }

  static String login() {
    return """
    """;
  }

  static String getEmployees = """
    query Employees {
      employees(first: 100) {
        paginatorInfo {
          total
          currentPage
          lastPage
        }
        data {
          id
          name
        }
      }
    }
  """;

  static String staffs = """
    query {
        staffs{
        id,
        name,
        rfid,
        pin_code
      }
    }
  """;

  static String users = """
    query {
        users{
        id,
        name,
        username,
        email
      }
    }
  """;
}
