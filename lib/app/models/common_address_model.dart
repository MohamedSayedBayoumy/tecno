class CommonResponseModel {
  final bool status;
  final String? message;

  CommonResponseModel({
    required this.status,
    required this.message,
  });

  // fromJson
  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
