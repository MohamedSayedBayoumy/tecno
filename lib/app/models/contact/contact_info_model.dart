class ContactInfoModel {
  final String label;
  final String value;

  ContactInfoModel({
    required this.label,
    required this.value,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      label: json['label']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class ContactInfoResponse {
  final bool status;
  final String message;
  final List<ContactInfoModel> data;

  ContactInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    return ContactInfoResponse(
      status: json['status'] ?? false,
      message: json['message']?.toString() ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ContactInfoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

