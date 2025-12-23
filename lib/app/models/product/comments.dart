import 'item_details_model.dart';

class CommentsResponse {
  final bool status;
  final String message;
  final CommentsData data;

  CommentsResponse({
    this.status = false,
    this.message = "",
    CommentsData? data,
  }) : data = data ?? CommentsData();

  factory CommentsResponse.fromJson(Map<String, dynamic> json) {
    return CommentsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null
          ? CommentsData.fromJson(json['data'])
          : CommentsData(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class CommentsData {
  final List<ReviewUser> commentsList;
  Pagination? pagination;

  CommentsData({
    List<ReviewUser>? reviews,
    Pagination? pagination,
  })  : commentsList = reviews ?? [],
        pagination = pagination ?? Pagination();

  factory CommentsData.fromJson(Map<String, dynamic> json) {
    return CommentsData(
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewUser.fromJson(e))
              .toList() ??
          [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : Pagination(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reviews": commentsList.map((e) => e.toJson()).toList(),
      "pagination": pagination!.toJson(),
    };
  }
}

class Review {
  final int id;
  final User user;
  final int rating;
  final String review;
  final String subject;
  final String createdAt;
  final String createdAtHuman;

  Review({
    this.id = 0,
    User? user,
    this.rating = 0,
    this.review = "",
    this.subject = "",
    this.createdAt = "",
    this.createdAtHuman = "",
  }) : user = user ?? User();

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : User(),
      rating: json['rating'] ?? 0,
      review: json['review'] ?? "",
      subject: json['subject'] ?? "",
      createdAt: json['created_at'] ?? "",
      createdAtHuman: json['created_at_human'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": user.toJson(),
      "rating": rating,
      "review": review,
      "subject": subject,
      "created_at": createdAt,
      "created_at_human": createdAtHuman,
    };
  }
}

class User {
  final String name;
  final String photo;
  final String initial;

  User({
    this.name = "",
    this.photo = "",
    this.initial = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? "",
      photo: json['photo'] ?? "",
      initial: json['initial'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "photo": photo,
      "initial": initial,
    };
  }
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final bool hasMorePages;
  final bool hasPreviousPages;
  final int nextPage;
  final int? prevPage;
  final int firstPage;
  final int lastPageNumber;
  final String nextPageUrl;
  final String? prevPageUrl;
  final String firstPageUrl;
  final String lastPageUrl;
  final String path;
  final Links links;

  Pagination({
    this.currentPage = 0,
    this.lastPage = 0,
    this.perPage = 0,
    this.total = 0,
    this.from = 0,
    this.to = 0,
    this.hasMorePages = false,
    this.hasPreviousPages = false,
    this.nextPage = 0,
    this.prevPage,
    this.firstPage = 0,
    this.lastPageNumber = 0,
    this.nextPageUrl = "",
    this.prevPageUrl,
    this.firstPageUrl = "",
    this.lastPageUrl = "",
    this.path = "",
    Links? links,
  }) : links = links ?? Links();

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
      from: json['from'] ?? 0,
      to: json['to'] ?? 0,
      hasMorePages: json['has_more_pages'] ?? false,
      hasPreviousPages: json['has_previous_pages'] ?? false,
      nextPage: json['next_page'] ?? 0,
      prevPage: json['prev_page'],
      firstPage: json['first_page'] ?? 0,
      lastPageNumber: json['last_page_number'] ?? 0,
      nextPageUrl: json['next_page_url'] ?? "",
      prevPageUrl: json['prev_page_url'],
      firstPageUrl: json['first_page_url'] ?? "",
      lastPageUrl: json['last_page_url'] ?? "",
      path: json['path'] ?? "",
      links: json['links'] != null ? Links.fromJson(json['links']) : Links(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_page": currentPage,
      "last_page": lastPage,
      "per_page": perPage,
      "total": total,
      "from": from,
      "to": to,
      "has_more_pages": hasMorePages,
      "has_previous_pages": hasPreviousPages,
      "next_page": nextPage,
      "prev_page": prevPage,
      "first_page": firstPage,
      "last_page_number": lastPageNumber,
      "next_page_url": nextPageUrl,
      "prev_page_url": prevPageUrl,
      "first_page_url": firstPageUrl,
      "last_page_url": lastPageUrl,
      "path": path,
      "links": links.toJson(),
    };
  }
}

class Links {
  final String first;
  final String last;
  final String? prev;
  final String? next;

  Links({
    this.first = "",
    this.last = "",
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'] ?? "",
      last: json['last'] ?? "",
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first": first,
      "last": last,
      "prev": prev,
      "next": next,
    };
  }
}
