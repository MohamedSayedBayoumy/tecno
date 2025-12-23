class BrandsResponse {
  final bool status;
  String? message;
  final BrandsData data;

  BrandsResponse({
    required this.status,
    this.message,
    required this.data,
  });

  factory BrandsResponse.fromJson(Map<String, dynamic> json) {
    return BrandsResponse(
      status: json['status'] ?? false,
      message: json['message'],
      data: BrandsData.fromJson(json['data'] ?? {}),
    );
  }
}

class BrandsData {
  final List<Brand> brands;
  final Pagination pagination;

  BrandsData({
    required this.brands,
    required this.pagination,
  });

  factory BrandsData.fromJson(Map<String, dynamic> json) {
    return BrandsData(
      brands: (json['brands'] as List<dynamic>? ?? [])
          .map((e) => Brand.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class Brand {
  final int id;
  final String name;
  final String slug;
  final String photo;
  final int status;
  final int isPopular;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.photo,
    required this.status,
    required this.isPopular,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      photo: json['photo'] ?? '',
      status: json['status'] ?? 0,
      isPopular: json['is_popular'] ?? 0,
    );
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
  final int prevPage;
  final int firstPage;
  final int lastPageNumber;
  final String nextPageUrl;
  final String prevPageUrl;
  final String firstPageUrl;
  final String lastPageUrl;
  final String path;
  final PaginationLinks links;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.hasMorePages,
    required this.hasPreviousPages,
    required this.nextPage,
    required this.prevPage,
    required this.firstPage,
    required this.lastPageNumber,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.path,
    required this.links,
  });

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
      prevPage: json['prev_page'] ?? 0,
      firstPage: json['first_page'] ?? 0,
      lastPageNumber: json['last_page_number'] ?? 0,
      nextPageUrl: json['next_page_url'] ?? '',
      prevPageUrl: json['prev_page_url'] ?? '',
      firstPageUrl: json['first_page_url'] ?? '',
      lastPageUrl: json['last_page_url'] ?? '',
      path: json['path'] ?? '',
      links: PaginationLinks.fromJson(json['links'] ?? {}),
    );
  }
}

class PaginationLinks {
  final String first;
  final String last;
  final String prev;
  final String next;

  PaginationLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'] ?? '',
      last: json['last'] ?? '',
      prev: json['prev'] ?? '',
      next: json['next'] ?? '',
    );
  }
}
