abstract class Auth {
  Map<String, dynamic> toJson();
}

class AuthModel extends Auth {
  String? userName;
  String? email;
  String? password;
  String? confirmpassword;

  AuthModel({this.userName, this.email, this.password, this.confirmpassword});
  @override
  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "email": email,
      "password": password,
      "password_confirm": confirmpassword,
    };
  }
}

class AuthGoogleModel extends Auth {
  AuthGoogleModel({this.email, this.googleId, this.profilePicture});
  String? email;
  String? googleId;
  String? profilePicture;

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "google_id": googleId,
      "profile_picture": profilePicture,
    };
  }
}

class AuthResetpasswordModel extends Auth {
  String? email;
  String? otp;
  String? newPassword;
  AuthResetpasswordModel({this.email, this.otp, this.newPassword});

  @override
  Map<String, dynamic> toJson() {
    return {"email": email, "otp": otp, "new_password": newPassword};
  }
}
