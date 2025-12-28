class BranchesResponse {
  final bool status;
  final String message;
  final List<BranchRegisterModel> data;

  const BranchesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  /// Initial values for all variables
  factory BranchesResponse.empty() => const BranchesResponse(
        status: false,
        message: '',
        data: <BranchRegisterModel>[],
      );

  factory BranchesResponse.fromJson(Map<String, dynamic> json) {
    return BranchesResponse(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BranchRegisterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <BranchRegisterModel>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class BranchRegisterModel {
  final int id;
  final int code;
  final String name;
  final String? description;
  final int parentId;
  final String key;
  final String createdAt;
  final String updatedAt;
  final String? value;
  final int? costCenterId;
  final int? accountId;
  final int createdBy;

  const BranchRegisterModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.parentId,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
    required this.value,
    required this.costCenterId,
    required this.accountId,
    required this.createdBy,
  });

  /// Initial values for all variables
  factory BranchRegisterModel.empty() => const BranchRegisterModel(
        id: 0,
        code: 0,
        name: '',
        description: null,
        parentId: 0,
        key: '',
        createdAt: '',
        updatedAt: '',
        value: null,
        costCenterId: null,
        accountId: null,
        createdBy: 0,
      );

  factory BranchRegisterModel.fromJson(Map<String, dynamic> json) {
    return BranchRegisterModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: (json['code'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      parentId: (json['parent_id'] as num?)?.toInt() ?? 0,
      key: json['key'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      value: json['value'] as String?,
      costCenterId: (json['cost_center_id'] as num?)?.toInt(),
      accountId: (json['account_id'] as num?)?.toInt(),
      createdBy: (json['created_by'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'description': description,
        'parent_id': parentId,
        'key': key,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'value': value,
        'cost_center_id': costCenterId,
        'account_id': accountId,
        'created_by': createdBy,
      };

  BranchRegisterModel copyWith({
    int? id,
    int? code,
    String? name,
    String? description,
    int? parentId,
    String? key,
    String? createdAt,
    String? updatedAt,
    String? value,
    int? costCenterId,
    int? accountId,
    int? createdBy,
  }) {
    return BranchRegisterModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      key: key ?? this.key,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      value: value ?? this.value,
      costCenterId: costCenterId ?? this.costCenterId,
      accountId: accountId ?? this.accountId,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
