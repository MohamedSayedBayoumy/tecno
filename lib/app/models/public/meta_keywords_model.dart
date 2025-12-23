class MetaKeywordsModel {
  MetaKeywordsModel({
    required this.value,
  });

  final String? value;

  factory MetaKeywordsModel.fromJson(Map<String, dynamic> json){
    return MetaKeywordsModel(
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
    "value": value,
  };

}