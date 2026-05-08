class User {
  String? id;
  String? email;
  String? username;
  dynamic profilePicture;
  DateTime? dateJoined;
  bool? isVerified;

  User({
    this.id,
    this.email,
    this.username,
    this.profilePicture,
    this.dateJoined,
    this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String?,
    email: json['email'] as String?,
    username: json['username'] as String?,
    profilePicture: json['profile_picture'] as dynamic,
    dateJoined: json['date_joined'] == null
        ? null
        : DateTime.parse(json['date_joined'] as String),
    isVerified: json['is_verified'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'username': username,
    'profile_picture': profilePicture,
    'date_joined': dateJoined?.toIso8601String(),
    'is_verified': isVerified,
  };
}
