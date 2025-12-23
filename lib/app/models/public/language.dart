class LanguageModel {
  LanguageModel({
    required this.language,
    required this.name,
  });

  final String? language;
  final String? name;

  factory LanguageModel.fromJson(Map<String, dynamic> json){
    return LanguageModel(
      language: json["language"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "name": name,
      };
}

/// Language keys used for static texts.
class LanguageKeys {
  static const String uploadFiles = 'upload_files';
  static const String commercialRegisterImage = 'commercial_register_image';
  static const String taxNumberImage = 'tax_number_image';
  static const String addressImage = 'address_image';
}
