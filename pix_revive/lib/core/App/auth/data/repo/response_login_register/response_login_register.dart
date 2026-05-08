import 'tokens.dart';
import 'user.dart';

class ResponseLoginRegister {
  User? user;
  Tokens? tokens;

  ResponseLoginRegister({this.user, this.tokens});

  factory ResponseLoginRegister.fromJson(Map<String, dynamic> json) {
    return ResponseLoginRegister(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      tokens: json['tokens'] == null
          ? null
          : Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'tokens': tokens?.toJson(),
  };
}
