class SystemMessage {
  static String sucClockedSuccess(String action) =>
      "You have registered as ${action.toUpperCase()}";

  static String errSystemError = "Oops.. Something went wrong!";
  static String errAuthError = "Username or Password is incorrect!";
  static String errNfcNullError = "No NFC tags identified!";
  static String errNfcNotValid(String id) =>
      "NFC tag is not identified!\n\nID: $id";
  static String errPinCodeNotValid(String pinCode) =>
      "Entered PIN CODE is not valid!\n\nPIN CODE : $pinCode";
  static String errSettingPinError = "Incorrect Pin!";
}
