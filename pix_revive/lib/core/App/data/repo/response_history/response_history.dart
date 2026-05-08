class ResponseHistory {
  int? id;
  String? imageUploaded;
  String? restoredImage;
  String? featureUsed;
  String? message;
  DateTime? createdAt;

  ResponseHistory({
    this.id,
    this.imageUploaded,
    this.restoredImage,
    this.featureUsed,
    this.createdAt,
    this.message,
  });

  factory ResponseHistory.fromJson(Map<String, dynamic> json) {
    return ResponseHistory(
      id: json['id'] as int?,

      imageUploaded: json['image_uploaded'] as String?,
      restoredImage: json['restored_image'] as String?,
      featureUsed: json['feature_used'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  factory ResponseHistory.fromJsonAi(Map<String, dynamic> json) {
    return ResponseHistory(
      id: json['history_id'] as int?,
      imageUploaded: json['original_image'] as String?,
      restoredImage: json['processed_image'] as String?,
      featureUsed: json['feature_used'] as String?,
      message: json['message'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'image_uploaded': imageUploaded,
    'restored_image': restoredImage,
    'feature_used': featureUsed,
    'created_at': createdAt?.toIso8601String(),
  };
}
