class CountryModel {
  CountryModel({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory CountryModel.fromJson(Map<String, dynamic> json){
    return CountryModel(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

}