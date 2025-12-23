class OptionSelection {
  int? id;
  String? names;
  String? optionName;
  int? optionId;
  double? optionPrice;

  OptionSelection(
      {required this.id, this.names, this.optionName, this.optionPrice,this.optionId});

  OptionSelection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json['names'];
    optionId = json['option_id'];
    optionName = json['option_name'];
    optionPrice = json['option_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['names'] = this.names;
    data['option_id'] = this.optionId;
    data['option_name'] = this.optionName;
    data['option_price'] = this.optionPrice;
    return data;
  }
}
