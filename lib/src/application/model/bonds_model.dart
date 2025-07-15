class BondsResponse {
  final List<BondsList> data;

  BondsResponse({required this.data});

  factory BondsResponse.fromJson(Map<String, dynamic> json) {
    return BondsResponse(
      data: (json['data'] as List)
          .map((item) => BondsList.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class BondsList {
  final String logo;
  final String isin;
  final String rating;
  final String companyName;
  final List<String> tags;

  BondsList({
    required this.logo,
    required this.isin,
    required this.rating,
    required this.companyName,
    required this.tags,
  });

  factory BondsList.fromJson(Map<String, dynamic> json) {
    return BondsList(
      logo: json['logo'] ?? '',
      isin: json['isin'] ?? '',
      rating: json['rating'] ?? '',
      companyName: json['company_name'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'isin': isin,
      'rating': rating,
      'company_name': companyName,
      'tags': tags,
    };
  }
}
