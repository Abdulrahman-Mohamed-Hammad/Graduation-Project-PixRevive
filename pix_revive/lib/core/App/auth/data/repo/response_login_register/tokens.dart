class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    refresh: json['refresh'] as String?,
    access: json['access'] as String?,
  );

  Map<String, dynamic> toJson() => {'refresh': refresh, 'access': access};
}
