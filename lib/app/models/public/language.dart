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