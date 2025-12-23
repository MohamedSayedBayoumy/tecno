// Dart models for the Notifications API response
// Covers: success, message, data { notifications[], pagination }
// No external packages required.

import 'dart:convert';

class NotificationsResponse {
  final bool success;
  final String message;
  final NotificationsData data;

  const NotificationsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: NotificationsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };

  /// Convenience: parse whole JSON string
  static NotificationsResponse fromJsonString(String source) =>
      NotificationsResponse.fromJson(
          json.decode(source) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  NotificationsResponse copyWith({
    bool? success,
    String? message,
    NotificationsData? data,
  }) =>
      NotificationsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );
}

class NotificationsData {
  final List<NotificationItem> notifications;
  final Pagination pagination;

  const NotificationsData({
    required this.notifications,
    required this.pagination,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    final list = (json['notifications'] as List<dynamic>? ?? [])
        .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    return NotificationsData(
      notifications: list,
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'notifications': notifications.map((e) => e.toJson()).toList(),
        'pagination': pagination.toJson(),
      };

  NotificationsData copyWith({
    List<NotificationItem>? notifications,
    Pagination? pagination,
  }) =>
      NotificationsData(
        notifications: notifications ?? this.notifications,
        pagination: pagination ?? this.pagination,
      );
}

class NotificationItem {
  final int? id, directId;
  final String title, direct;
  final String body;
  final DateTime? sentAt; // parsed from ISO string `sent_at`
  final bool isRead;
  final bool fromNotification;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.sentAt,
    required this.isRead,
    this.directId,
    required this.direct,
    this.fromNotification = false,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      direct: json['direct'] as String? ?? '',
      directId: json['direct_id'] ?? -1,
      sentAt: json['sent_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['sent_at'] as String),
      isRead: json['is_read'] as bool? ?? false,
      fromNotification: json['fromNotification'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'sent_at': sentAt!.toUtc().toIso8601String(),
        'is_read': isRead,
        'fromNotification': fromNotification,
      };

  NotificationItem copyWith(
          {int? id,
          String? title,
          String? body,
          String? direct,
          DateTime? sentAt,
          bool? isRead,
          bool? fromNotification}) =>
      NotificationItem(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        sentAt: sentAt ?? this.sentAt,
        isRead: isRead ?? this.isRead,
        fromNotification: fromNotification ?? this.fromNotification,
        direct: direct ?? this.direct,
      );
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMore;

  const Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMore,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: (json['current_page'] as num).toInt(),
        lastPage: (json['last_page'] as num).toInt(),
        perPage: (json['per_page'] as num).toInt(),
        total: (json['total'] as num).toInt(),
        hasMore: json['has_more'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total,
        'has_more': hasMore,
      };

  Pagination copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    bool? hasMore,
  }) =>
      Pagination(
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        hasMore: hasMore ?? this.hasMore,
      );
}

// ------------------ Example usage ------------------
// final res = NotificationsResponse.fromJson(apiMap);
// print(res.data.notifications.first.title);
// final jsonString = res.toJsonString();
